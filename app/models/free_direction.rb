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

class FreeDirection < ApplicationRecord
  belongs_to :origin, class_name: 'City'
  belongs_to :destination, class_name: 'City'

  validates :origin_id, :destination_id, presence: true
  validates :origin, uniqueness: { scope: :destination_id }
end
