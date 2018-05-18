class Import::Offers::OneSideCheapestOfferService
  MONTH_PERIOD_ARRAY = (0..6).to_a

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @user = User.admin.take
    @statistic = {}
  end

  def call
    offers = []

    MONTH_PERIOD_ARRAY.each do |number|
      # Each iteration increments month + 1
      # So for example the first iteration - april, second - may, etc.
      date = Date.today.at_beginning_of_month + number.month
      fetch_service = fetch_offers(date)
      if fetch_service.failure?
        Logger.new(STDOUT).warn("#{self.class.name} || #{origin.name} - #{destination.name} || #{fetch_service.error}")
        next
      end

      offers << fetch_service.result
      offers = offers.flatten

      handle_statistic(date, offers)

      if last_month?(number)
        return if offers.empty?

        cheapest_offer = find_cheapest_unique_offer(offers)

        return if cheapest_offer.nil?
        return if price_more_than_average_with_discount?(cheapest_offer['value'], price_average(offers))

        create_offer(cheapest_offer, price_average(offers))
      end
    end
  end

  private

  attr_reader :origin, :destination, :user, :statistic

  def fetch_offers(date)
    ::ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: origin.iata, destination: destination.iata, month: date)
  end

  def price_average(offers)
    prices_array = offers.map { |hash| hash['value'] }
    (prices_array.reduce(:+) / prices_array.size).round
  end

  def price_more_than_average_with_discount?(value, average)
    coef = (100 - Offer::REQUIRED_IMPORT_DICOUNT_PERCENT) * 0.01
    value.round > (average * coef).round
  end

  def calculate_percent_difference(value, average)
    100 - (value / average.to_f * 100).round
  end

  def handle_statistic(date, offers)
    return if offers.empty?

    month_name = Date::MONTHNAMES[date.month]
    month_data = {
      average: price_average(offers),
      date_start: date.at_beginning_of_month,
      date_end: date.end_of_month
    }

    # [[nil, 1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12, 13], [14, 15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27], [28, 29, 30, 31]]
    weeks_data = {}
    weeks_array = date.week_split
    weeks_array.each_with_index do |array, index|
      result = offers.select { |offer| array.include?(Date.parse(offer['depart_date']).day) }

      next if result.empty?

      weeks_data[index + 1] = {
        date_start: Date.new(date.year, date.month, date.day).change(day: array.compact.first),
        date_end: Date.new(date.year, date.month, date.day).change(day: array.compact.last),
        average: price_average(result)
      }
    end

    statistic[month_name] = month_data
    statistic[month_name]['weeks'] = weeks_data
  end

  def last_month?(number)
    number == MONTH_PERIOD_ARRAY.last
  end

  def find_cheapest_unique_offer(offers)
    sorted_offers = offers.sort_by { |offer| offer['value'] }
    cheapest_offer = sorted_offers.first
    return nil if cheapest_offer.nil?

    # If this offer already published, need to check the next one(with recursion)
    return find_cheapest_unique_offer(sorted_offers.tap{|a| a.delete_at(0)}) if offer_exists?(cheapest_offer)

    cheapest_offer
  end

  def determine_airport(city)
    airports = city.airports
    airports.take if airports.length == 1
  end

  def offer_exists?(data)
    Offer.find_by(
      origin_id: origin.id,
      destination_id: destination.id,
      price: data['value'],
      date_from: data['depart_date']
    ).present?
  end

  def create_offer(data, average)
    Offer.create!(
      offer_type: 'airplane',
      two_sides: false,
      user: user,
      price: data['value'],
      origin: origin,
      destination: destination,
      from_airport: determine_airport(origin),
      gate: data['gate'],
      date_from: data['depart_date'],
      discount_rate: calculate_percent_difference(data['value'], average),
      statistic: statistic
    )
  end
end
