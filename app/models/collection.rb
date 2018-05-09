# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  name_en    :string
#  desc       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collection < ApplicationRecord
  paginates_per 20

  validates :name, :user_id, presence: true

  has_many :offer_collections, dependent: :destroy
  has_many :offers, through: :offer_collections, source: 'offer'

  belongs_to :user

  accepts_nested_attributes_for :offer_collections, allow_destroy: true
end
