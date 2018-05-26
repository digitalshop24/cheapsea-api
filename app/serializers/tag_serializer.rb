# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  has_many :offers
end
