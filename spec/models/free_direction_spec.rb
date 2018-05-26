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

require 'rails_helper'

describe FreeDirection, type: :model do
  it { is_expected.to validate_presence_of(:origin_id) }
  it { is_expected.to validate_presence_of(:destination_id) }
  it { is_expected.to belong_to(:destination) }
  it { is_expected.to belong_to(:origin) }
end
