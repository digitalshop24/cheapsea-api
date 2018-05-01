module Import::CountriesService
  def self.call
    return if Country.any?

    puts 'Countries import started'

    countries = JSON.parse(File.read("#{Rails.root}/lib/import/countries.json"))

    countries.each do |country|
      Country.create!(iata: country['code'], name: country['name_translations']['ru'], name_en: country['name'])
    end

    puts "#{Country.count} countries imported"
  end
end
