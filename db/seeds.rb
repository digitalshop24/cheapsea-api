User.destroy_all
Offer.destroy_all

user = User.create!(email: 'admin@gmail.com', password: 'password')
user.offers.create!(name: 'First offer', from_google_place_id: 'ChIJOwg_06VPwokRYv534QaPC8g', to_google_place_id: 'ChIJGzE9DS1l44kRoOhiASS_fHg')