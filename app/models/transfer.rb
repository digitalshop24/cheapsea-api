# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  offer_id        :integer          not null
#  google_place_id :string
#  airline_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Transfer < ApplicationRecord
  belongs_to :offer, counter_cache: true
  belongs_to :airline, optional: true
  belongs_to :user

  validates :offer_id, presence: true
end
