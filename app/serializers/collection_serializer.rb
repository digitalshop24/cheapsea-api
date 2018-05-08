# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  name_en    :string
#  desc       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CollectionSerializer < ActiveModel::Serializer
  attributes :name, :name_en, :desc

  has_many :offers
end
