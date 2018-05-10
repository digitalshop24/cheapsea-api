# == Schema Information
#
# Table name: offers
#
#  id                              :integer          not null, primary key
#  offer_type                      :integer
#  discount_type                   :integer
#  name                            :string
#  airline_id                      :integer
#  is_direct                       :boolean          default(TRUE)
#  transfers_count                 :integer
#  date_from                       :datetime
#  date_to                         :datetime
#  date_end                        :datetime
#  discount_rate                   :integer
#  description                     :text
#  status                          :integer          default("draft"), not null
#  user_id                         :integer
#  price                           :float
#  price_currency                  :string           default("RUB")
#  two_sides                       :boolean          default(FALSE), not null
#  flight_number                   :integer
#  gate                            :string
#  origin_id                       :integer
#  destination_id                  :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  from_airport_id                 :integer
#  to_airport_id                   :integer
#  name_auto                       :string
#  visits_count                    :integer          default(0), not null
#  images_countries_square_id      :integer
#  images_countries_rectangular_id :integer
#

class Offer < ApplicationRecord
  before_save do
    generate_name
    import_cheapest_offer_before_save
  end
  before_create :add_country_images
  after_destroy :import_cheapest_offer_after_destroy

  CURRENCY_TYPES = %w(RUB USD EUR)

  enum status: { draft: 0, published: 1 }
  enum offer_type: { airplane: 0, trane: 1, bus: 2, car_rent: 3 }
  enum discount_type: { hot: 0, seasonal: 1, erroneous: 2, other: 3 }
  enum quality: { unknown: 0, bad: 1, normal: 2, good: 3 }

  paginates_per 20

  belongs_to :user
  belongs_to :airline, optional: true
  belongs_to :origin, class_name: 'City', foreign_key: 'origin_id'
  belongs_to :destination, class_name: 'City', foreign_key: 'destination_id'
  belongs_to :from_airport, class_name: 'Airport', foreign_key: 'from_airport_id', optional: true
  belongs_to :to_airport, class_name: 'Airport', foreign_key: 'to_airport_id', optional: true
  belongs_to :images_countries_square, class_name: 'Images::Countries::Square', optional: true
  belongs_to :images_countries_rectangular, class_name: 'Images::Countries::Rectangular', optional: true

  has_many :transfers, dependent: :destroy
  has_many :offer_tags, dependent: :destroy
  has_many :tags, through: :offer_tags, source: 'tag'

  validates :is_direct, inclusion: { in: [ true, false ] }
  validates :two_sides, inclusion: { in: [ true, false ] }
  validates :price_currency, inclusion: { in: CURRENCY_TYPES }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :origin_id, :destination_id, :is_direct, :price_currency, :price, presence: true

  scope :two_sides, -> { where(two_sides: true) }
  scope :one_side, -> { where(two_sides: false) }

  accepts_nested_attributes_for :transfers, allow_destroy: true
  accepts_nested_attributes_for :offer_tags, allow_destroy: true

  private

  def import_cheapest_offer_before_save
    return unless status_changed?(from: 'draft', to: 'published')

    import_cheapest_offer
  end

  def import_cheapest_offer_after_destroy
    import_cheapest_offer
  end

  def import_cheapest_offer
    return if two_sides?

    Import::OneSideCheapestOfferWorker.perform_async(origin.id, destination.id)
  end

  def generate_name
    triggered_fields = %w[origin_id destination_id date_to date_from price price_currency]

    return if (triggered_fields & changes.keys).empty?

    self.name_auto = Offers::GenerateNameService.call(self)
    self.name ||= self.name_auto
  end

  def add_country_images
    square_image = destination.country.square_images.sample
    rectangular_image = destination.country.rectangular_images.sample

    self.images_countries_square_id = square_image&.id
    self.images_countries_rectangular_id = rectangular_image&.id
  end
end
