# == Schema Information
#
# Table name: offer_collections
#
#  id            :integer          not null, primary key
#  offer_id      :integer          not null
#  collection_id :integer          not null
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OfferCollection < ApplicationRecord
  validates :offer_id, :collection_id, presence: true
  validates :offer_id, uniqueness: { scope: :collection_id }

  belongs_to :offer
end
