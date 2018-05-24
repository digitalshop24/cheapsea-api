class AirlinesIndex < Chewy::Index
  define_type Airline do
    field :id
    field :name
  end
end
