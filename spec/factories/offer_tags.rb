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

FactoryGirl.define do
  factory :offer_tag do
    offer ""
    tag nil
  end
end
