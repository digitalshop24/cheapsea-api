class AirportsIndex < Chewy::Index
  define_type Airport do
    field :id
    field :name
    field :name_en
  end
end
