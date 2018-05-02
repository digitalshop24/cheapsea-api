module Offers::GenerateNameService
  def self.call(offer)
    origin = offer.origin || ''
    destination = offer.destination || ''
    month_name = Russian::strftime(offer.date_from, "%B") || ''
    price = "#{offer.price.to_i}"
    price_currency = offer.price_currency == 'RUB' ? 'руб.' : '$'
    type = offer.is_direct? ? 'прямой' : 'составной'

    "#{origin.name} - #{destination.name}. #{month_name}, #{price}#{price_currency}, #{type}."
  end
end
