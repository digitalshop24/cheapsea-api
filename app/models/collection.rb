class Collection < ApplicationRecord
  paginates_per 20

  validates :name, presence: true

  has_many :offer_collections
  has_many :offers, through: :offer_collections, source: 'offer'
end
