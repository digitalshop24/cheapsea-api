FactoryGirl.define do
  factory :airport do
    name "MyString"
    name_en "MyString"
    country ""
    city ""
    iata "MyString"
    flightable false
    latitude 1.5
    langitude 1.5
  end
end
