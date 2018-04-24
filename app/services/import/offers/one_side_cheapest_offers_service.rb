class Import::Offers::OneSideCheapestOffersService
  MONTH_PERIOD_ARRAY = (0..6).to_a

  def call
    cities = City.active
    @user = User.admin.take

    cities.each_with_index do |origin, index|
      puts "#{origin.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |destination|
        next if the_same_point?(origin, destination)

        google_places = google_places_info(origin, destination)
        next if google_places.keys.length < 2

        next if any_draft_offers?(google_places)

        offers = []

        MONTH_PERIOD_ARRAY.each do |number|
          date = Date.today.at_beginning_of_month + number.month
          fetch_service = fetch_offers(origin, destination, date)
          next if fetch_service.failure?

          offers << fetch_service.result

          if last_month?(number)
            cheapest_offer = find_cheapest_unique_offer(offers, google_places)
            next if cheapest_offer.nil?
            create_offer(origin, destination, cheapest_offer, google_places)
          end
        end
      end
    end
  end

  attr_reader :user

  private

  def the_same_point?(origin, destination)
    origin.id == destination.id
  end

  def any_draft_offers?(google_places)
    Offer.draft.one_side.find_by(
      from_google_place_id: google_places[:from_google_place_id],
      to_google_place_id: google_places[:to_google_place_id]
    ).present?
  end

  def fetch_offers(origin, destination, date)
    ::ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: origin.iata, destination: destination.iata, month: date)
  end

  def last_month?(number)
    number == MONTH_PERIOD_ARRAY.last
  end

  def find_cheapest_unique_offer(offers, google_places)
    sorted_offers = offers.flatten.sort_by { |offer| offer['value'] }
    cheapest_offer = sorted_offers.first
    return nil if cheapest_offer.nil?

    return find_cheapest_unique_offer(sorted_offers.tap{|a| a.delete_at(0)}, google_places) if offer_exists?(cheapest_offer, google_places)

    cheapest_offer
  end

  def offer_exists?(data, google_places)
    Offer.published.find_by(
      from_google_place_id: google_places[:from_google_place_id],
      to_google_place_id: google_places[:to_google_place_id],
      price: data['value'],
      date_from: data['depart_date']
    ).present?
  end

  def google_places_info(origin, destination)
    {
      from_google_place_id: ::ThirdParty::Geo::AutocompleteService.call(input: origin.name).result.first['place_id'],
      to_google_place_id: ::ThirdParty::Geo::AutocompleteService.call(input: destination.name).result.first['place_id']
    }
  end

  def create_offer(origin, destination, data, google_places)
    Offer.create!(
      offer_type: 'airplane',
      two_sides: false,
      user: user,
      price: data['value'],
      name: "From #{origin.name} to #{destination.name} for #{data['value']} RUB.",
      from_google_place_id: google_places[:from_google_place_id],
      to_google_place_id: google_places[:to_google_place_id],
      gate: data['gate'],
      date_from: data['depart_date']
    )
  end
end
