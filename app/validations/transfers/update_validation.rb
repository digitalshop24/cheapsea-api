Transfers::UpdateValidation = Dry::Validation.Form do
  configure do
    config.messages_file = "#{Rails.root}/config/locales/en.yml"

    def place_existed?(place_id)
      Geo::PlaceInfoService.call(place_id: place_id).result.present?
    end
  end

  optional(:google_place_id).maybe(:str?, :place_existed?)
end
