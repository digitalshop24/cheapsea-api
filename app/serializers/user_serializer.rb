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
#  phone           :string
#

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email, :role, :phone
end
