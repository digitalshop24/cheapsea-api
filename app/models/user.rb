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

class User < ApplicationRecord
  has_secure_password

  mount_uploader :image, ImageUploader

  has_many :offers, dependent: :nullify

  enum role: { member: 0, agent: 1, moderator: 2, admin: 3 }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
