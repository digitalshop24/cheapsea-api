# TODO: add specs

Offers::CreateValidation = Dry::Validation.Form do
  configure do
    config.messages_file = "#{Rails.root}/config/locales/en.yml"

    def place_existed?(place_id)
      Geo::PlaceInfo.call(place_id: place_id).result.present?
    end
  end

  required(:from_google_place_id).filled(:str?, :place_existed?)
  required(:to_google_place_id).filled(:str?, :place_existed?)
  required(:name).filled(:str?)
end