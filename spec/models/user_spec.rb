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

require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many(:offers) }
end
