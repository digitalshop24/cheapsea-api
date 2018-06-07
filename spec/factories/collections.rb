# == Schema Information
#
# Table name: collections
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  name_en      :string
#  desc         :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :integer          default("draft"), not null
#  published_at :datetime
#  main         :boolean          default(FALSE), not null
#  image        :string
#  short_desc   :text
#

FactoryGirl.define do
  factory :collection do
    name "MyString"
    name_en "MyString"
    desc "MyText"
  end
end
