class CitiesIndex < Chewy::Index
  define_type City.includes(:airports) do
    field :id
    field :name
    field :name_en
    field :airports do
      field :id
      field :name
    end
  end
end
