# == Schema Information
#
# Table name: offer_tags
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OfferTag < ApplicationRecord
  belongs_to :tag
  belongs_to :offer

  validates :tag_id, presence: true
  validates :tag_id, uniqueness: { scope: :offer_id }
end
