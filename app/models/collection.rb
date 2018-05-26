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
#

class Collection < ApplicationRecord
  paginates_per 20

  enum status: { draft: 0, published: 1 }

  validates :name, :user_id, presence: true

  has_many :offer_collections, dependent: :destroy
  has_many :offers, through: :offer_collections, source: 'offer'

  belongs_to :user

  accepts_nested_attributes_for :offer_collections, allow_destroy: true

  before_save :update_published_at_if_status_changed_to_published

  private

  def update_published_at_if_status_changed_to_published
    self.published_at = Time.zone.now if status_changed?(from: 'draft', to: 'published')
  end
end
