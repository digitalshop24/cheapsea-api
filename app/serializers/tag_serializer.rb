class TagSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  has_many :offers
end
