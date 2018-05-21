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

class CollectionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :name_en, :desc

  attribute :offers do |collection|
    collection.offers.order(price: :asc)
  end
end
