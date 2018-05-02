# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  role            :integer          default("member")
#  password_digest :string           not null
#  image           :string
#

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@gmail.com"
    end
    role 'agent'
    password 'password'
  end
end
