User.create!(email: 'admin@gmail.com', password: 'password', role: 'member')
User.create!(email: 'agent@gmail.com', password: 'password', role: 'agent')
User.create!(email: 'member@gmail.com', password: 'password', role: 'admin')
User.create!(email: 'moderator@gmail.com', password: 'password', role: 'moderator')

Rake::Task['import:countries'].invoke
Rake::Task['import:cities'].invoke
Rake::Task['import:airlines'].invoke
Rake::Task['import:airports'].invoke

User.find_each do |user|
  user.offers.create!(
    name: "#{user.role} offer",
    price: 1,
    origin: City.active.first,
    destination: City.active.last,
    airline: Airline.first)
end
