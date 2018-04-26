class Import::Offers::OneSideCheapestOfferService
  MONTH_PERIOD_ARRAY = (0..6).to_a

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @user = User.admin.take
  end

  def call
    offers = []

    MONTH_PERIOD_ARRAY.each do |number|
      # Each iteration increments month + 1
      # So for example the first iteration - april, second - may, etc.
      date = Date.today.at_beginning_of_month + number.month
      fetch_service = fetch_offers(date)
      next if fetch_service.failure?

      offers << fetch_service.result

      if last_month?(number)
        cheapest_offer = find_cheapest_unique_offer(offers)
        next if cheapest_offer.nil?
        create_offer(cheapest_offer)
      end
    end
  end

  private

  attr_reader :origin, :destination, :user

  def fetch_offers(date)
    ::ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: origin.iata, destination: destination.iata, month: date)
  end

  def last_month?(number)
    number == MONTH_PERIOD_ARRAY.last
  end

  def find_cheapest_unique_offer(offers)
    sorted_offers = offers.flatten.sort_by { |offer| offer['value'] }
    cheapest_offer = sorted_offers.first
    return nil if cheapest_offer.nil?

    return find_cheapest_unique_offer(sorted_offers.tap{|a| a.delete_at(0)}) if offer_exists?(cheapest_offer)

    cheapest_offer
  end

  def offer_exists?(data)
    Offer.published.find_by(
      origin_id: origin.id,
      destination_id: destination.id,
      price: data['value'],
      date_from: data['depart_date']
    ).present?
  end

  def create_offer(data)
    Offer.create!(
      offer_type: 'airplane',
      two_sides: false,
      user: user,
      price: data['value'],
      name: "From #{origin.name} to #{destination.name} for #{data['value']} RUB.",
      origin: origin,
      destination: destination,
      gate: data['gate'],
      date_from: data['depart_date']
    )
  end
end
