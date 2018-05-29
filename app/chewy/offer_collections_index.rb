class OfferCollectionsIndex < Chewy::Index
  define_type OfferCollection do
    field :offer_id
    field :collection_id
  end
end
