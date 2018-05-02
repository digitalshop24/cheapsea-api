# == Schema Information
#
# Table name: offers
#
#  id                   :integer          not null, primary key
#  offer_type           :integer
#  discount_type        :integer
#  name                 :string
#  from_google_place_id :string
#  to_google_place_id   :string
#  airline_id           :integer
#  is_direct            :boolean          default(TRUE)
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  price                :float
#  price_currency       :string           default("RUB")
#  two_sides            :boolean          default(FALSE), not null
#  flight_number        :integer
#  gate                 :string
#  origin_id            :integer
#  destination_id       :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  from_airport_id      :integer
#  to_airport_id        :integer
#

class Offer < ApplicationRecord
  before_save do
    synchronize_places
    generate_name
    import_cheapest_offer
  end

  CURRENCY_TYPES = %w(RUB USD EUR)

  enum status: { draft: 0, published: 1 }
  enum offer_type: { airplane: 0, trane: 1, bus: 2, car_rent: 3 }
  enum discount_type: { hot: 0, seasonal: 1, erroneous: 2, other: 3 }

  paginates_per 20

  belongs_to :user
  belongs_to :airline, optional: true
  belongs_to :origin, class_name: 'City', foreign_key: 'origin_id', optional: true
  belongs_to :destination, class_name: 'City', foreign_key: 'destination_id', optional: true
  belongs_to :from_airport, class_name: 'Airport', foreign_key: 'from_airport_id', optional: true
  belongs_to :to_airport, class_name: 'Airport', foreign_key: 'to_airport_id', optional: true

  has_many :transfers, dependent: :destroy

  validates :is_direct, presence: true, inclusion: { in: [ true, false ] }
  validates :two_sides, inclusion: { in: [ true, false ] }
  validates :price_currency, presence: true, inclusion: { in: CURRENCY_TYPES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :two_sides, -> { where(two_sides: true) }
  scope :one_side, -> { where(two_sides: false) }

  private

  def synchronize_places
    return if Rails.env.test?

    synchronize_google_places if origin_id_changed? || destination_id_changed?
    synchronize_city_places if from_google_place_id_changed? || to_google_place_id_changed?
  end

  def synchronize_google_places
    service = ThirdParty::Geo::PlaceIdsFromNamesService.call(origin_name: origin.name, destination_name: destination.name)

    if service.failure?
      errors.add(:base, service.error)
      throw :abort
    end

    self.from_google_place_id = service.result[:from_google_place_id]
    self.to_google_place_id = service.result[:to_google_place_id]

    return
  end

  def synchronize_city_places
    service = ThirdParty::Geo::CitiesFromPlaceIdsService.call(from_google_place_id: from_google_place_id, to_google_place_id: to_google_place_id)

    if service.failure?
      errors.add(:base, service.error)
      throw :abort
    end

    self.origin = service.result[:origin]
    self.destination = service.result[:destination]
  end


  def import_cheapest_offer
    return if two_sides?
    return unless status_changed?(from: 'draft', to: 'published')

    Import::OneSideCheapestOfferWorker.perform_async(origin.id, destination.id)
  end

  def generate_name
    triggered_fields = %w[origin_id destination_id date_to date_from price price_currency]

    return if (triggered_fields & changes.keys).empty?

    self.name_auto = Offers::GenerateNameService.call(self)
  end
end
