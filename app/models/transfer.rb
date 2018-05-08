# == Schema Information
#
# Table name: transfers
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  airline_id :integer
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#

class Transfer < ApplicationRecord
  belongs_to :offer, counter_cache: true
  belongs_to :airline, optional: true
  belongs_to :user
  belongs_to :city

  validates :offer_id, :city_id, presence: true
end
