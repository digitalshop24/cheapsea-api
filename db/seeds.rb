User.create!(email: 'admin@gmail.com', password: 'password')
User.create!(email: 'member@gmail.com', password: 'password', role: 'admin')
User.create!(email: 'moderator@gmail.com', password: 'password', role: 'moderator')
User.find_each do |user|
  user.offers.create!(name: "#{user.role} offer", from_google_place_id: 'ChIJOwg_06VPwokRYv534QaPC8g', to_google_place_id: 'ChIJGzE9DS1l44kRoOhiASS_fHg')
end
