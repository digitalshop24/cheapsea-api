class FreeDirection < ApplicationRecord
  belongs_to :origin, class_name: 'City'
  belongs_to :destination, class_name: 'City'

  validates :origin_id, :destination_id, presence: true
  validates :origin, uniqueness: { scope: :destination_id }
end
