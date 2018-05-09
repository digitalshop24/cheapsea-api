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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :phone
end
