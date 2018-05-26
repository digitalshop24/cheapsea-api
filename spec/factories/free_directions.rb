# == Schema Information
#
# Table name: free_directions
#
#  id             :integer          not null, primary key
#  origin_id      :integer          not null
#  destination_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :free_direction do
    origin nil
    destination nil
  end
end
