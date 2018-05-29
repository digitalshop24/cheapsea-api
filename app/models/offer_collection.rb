# == Schema Information
#
# Table name: offer_collections
#
#  id            :integer          not null, primary key
#  offer_id      :integer          not null
#  collection_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OfferCollection < ApplicationRecord
  validates :offer_id, presence: true
  validates :offer_id, uniqueness: { scope: :collection_id }

  belongs_to :offer
  belongs_to :collection

  update_index('offer_collections#offer_collection') { self }
end
