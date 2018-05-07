class OfferCollection < ApplicationRecord
  validates :offer_id, :collection_id, presence: true
  validates :offer_id, uniqueness: { scope: :collection_id }

  belongs_to :offer
end
