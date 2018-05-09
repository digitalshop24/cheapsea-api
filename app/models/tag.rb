# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :user

  has_many :offer_tags, dependent: :destroy
  has_many :offers, through: :offer_tags, source: 'offer'
end
