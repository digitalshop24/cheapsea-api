module Offers::GenerateNameService
  # TODO add spec
  def self.call(offer)
    origin_name = offer&.origin&.name || ''
    destination_name = offer&.destination&.name || ''
    month_name = begin
      Russian::strftime(offer.date_from, "%B")
    rescue
      ''
    end
    price = "#{offer.price.to_i}"
    price_currency = offer.price_currency == 'RUB' ? 'руб.' : '$'
    type = offer.is_direct? ? 'прямой' : 'составной'

    "#{origin_name} - #{destination_name}. #{month_name}, #{price}#{price_currency}, #{type}."
  end
end
