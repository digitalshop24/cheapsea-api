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

class FreeDirectionSerializer
  include FastJsonapi::ObjectSerializer

  attribute :origin do |object|
    object.origin
  end

  attribute :destination do |object|
    object.destination
  end
end
