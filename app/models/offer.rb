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
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_direct            :boolean          default(TRUE)
#  price_cents          :integer          default(0), not null
#  price_currency       :string           default("USD"), not null
#

class Offer < ApplicationRecord
  before_validation :synronize_places
  before_save :import_cheapest_offer

  CURRENCY_TYPES = %w(RUB USD EUR)

  enum status: { draft: 0, published: 1 }
  enum offer_type: { airplane: 0, trane: 1, bus: 2, car_rent: 3 }
  enum discount_type: { hot: 0, seasonal: 1, erroneous: 2, other: 3 }

  paginates_per 20

  belongs_to :user
  belongs_to :airline, optional: true
  belongs_to :origin, class_name: 'City', foreign_key: 'origin_id'
  belongs_to :destination, class_name: 'City', foreign_key: 'destination_id'

  has_many :transfers, dependent: :destroy

  validates :name, :origin_id, :destination_id, presence: true
  validates :is_direct, presence: true, inclusion: { in: [ true, false ] }
  validates :two_sides, inclusion: { in: [ true, false ] }
  validates :price_currency, presence: true, inclusion: { in: CURRENCY_TYPES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :two_sides, -> { where(two_sides: true) }
  scope :one_side, -> { where(two_sides: false) }

  private

  def synronize_places
    # TODO add spec
    if self.origin_id_changed? || self.destination_id_changed?
      service = ThirdParty::Geo::PlaceIdsFromNamesService.call(origin_name: self.origin.name, destination_name: self.destination.name)

      if service.failure?
        errors.add(:base, service.error)
        throw :abort
      end

      self.from_google_place_id = service.result[:from_google_place_id]
      self.to_google_place_id = service.result[:to_google_place_id]
    end
  end

  def import_cheapest_offer
    return if self.two_sides?
    return unless self.status_changed?(from: 'draft', to: 'published')

    Import::OneSideCheapestOfferWorker.perform_async(self.origin.id, self.destination.id)
  end
end
