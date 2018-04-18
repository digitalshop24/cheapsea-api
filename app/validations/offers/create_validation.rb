Offers::CreateValidation = Dry::Validation.Form do
  configure do
    predicates(RelationsPredicates)

    config.messages_file = "#{Rails.root}/config/locales/en.yml"
  end

  required(:from_google_place_id).filled(:str?, :place_exists?)
  required(:to_google_place_id).filled(:str?, :place_exists?)
  required(:name).filled(:str?)
  optional(:airline_id).maybe(:airline_exists?)
end
