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
#  image        :string
#  short_desc   :text
#

require 'rails_helper'

describe Collection, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to have_many(:offer_collections) }
  it { is_expected.to have_many(:offers) }
  it { is_expected.to belong_to(:user) }
end
