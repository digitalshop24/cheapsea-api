User.create!(email: 'admin@gmail.com', password: 'password', role: 'member')
User.create!(email: 'agent@gmail.com', password: 'password', role: 'agent')
User.create!(email: 'member@gmail.com', password: 'password', role: 'admin')
User.create!(email: 'moderator@gmail.com', password: 'password', role: 'moderator')

Import::CitiesService.call

User.find_each do |user|
  user.offers.create!(
    name: "#{user.role} offer",
    price: 1,
    origin: City.active.first,
    destination: City.active.last)
end
