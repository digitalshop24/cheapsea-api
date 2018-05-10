# == Schema Information
#
# Table name: continents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContinentSerializer < ActiveModel::Serializer
  attributes :name
end