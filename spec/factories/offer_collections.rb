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

FactoryGirl.define do
  factory :offer_collection do
    offer ""
    collection ""
  end
end
