Transfers::UpdateValidation = Dry::Validation.Form do
  configure do
    predicates(RelationsPredicates)

    config.messages_file = "#{Rails.root}/config/locales/en.yml"
  end

  optional(:google_place_id).maybe(:str?, :place_exists?)
  optional(:airline_id).maybe(:airline_exists?)
end
