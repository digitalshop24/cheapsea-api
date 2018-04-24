module Import::CitiesService
  def self.call
    ::City.delete_all

    puts 'Cities import started'

    cities = JSON.parse(File.read("#{Rails.root}/lib/import/cities.json"))
    active_cities = Cities::TopHundredValueObject.call

    cities.each do |city|
      iata = city.first
      name = city.second['name']
      active = active_cities.include?(name)

      City.create!(iata: iata, name: name, active: active)
    end

    puts "#{City.count} cities imported"
  end
end
