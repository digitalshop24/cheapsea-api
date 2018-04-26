class Import::Offers::OneSideCheapestOffersService
  def call
    cities = City.active

    cities.each_with_index do |origin, index|
      puts "#{self.class.name} | #{origin.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |destination|
        next if the_same_point?(origin.id, destination.id)
        next if any_draft_offers?(origin.id, destination.id)

        Import::Offers::OneSideCheapestOfferService.new(origin, destination).call
      end

      sleep 10
    end
  end

  private

  def the_same_point?(origin_id, destination_id)
    origin_id == destination_id
  end

  def any_draft_offers?(origin_id, destination_id)
    Offer.draft.one_side.find_by(origin_id: origin_id, destination_id: destination_id).present?
  end
end
