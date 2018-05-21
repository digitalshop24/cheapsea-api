module Cities::TopHundredValueObject
  def self.call
    [
      { name: "Агра", iata: "AGR" },
      { name: "Окленд", iata: "AKL" },
      { name: "Амстердам", iata: "AMS" },
      { name: "Афины", iata: "ATH" },
      { name: "Абу-Даби", iata: "AUH" },
      { name: "Барселона", iata: "BCN" },
      { name: "Берлин", iata: "BER" },
      { name: "Пекин", iata: "BJS" },
      { name: "Бангкок", iata: "BKK" },
      { name: "Мумбаи", iata: "BOM" },
      { name: "Брюссель", iata: "BRU" },
      { name: "Будапешт", iata: "BUD" },
      { name: "Буэнос-Айрес", iata: "BUE" },
      { name: "Каир", iata: "CAI" },
      { name: "Гуанчжоу", iata: "CAN" },
      { name: "Калькутта", iata: "CCU" },
      { name: "Коломбо", iata: "CMB" },
      { name: "Чиангмай", iata: "CNX" },
      { name: "Копенгаген", iata: "CPH" },
      { name: "Канкун", iata: "CUN" },
      { name: "Дели", iata: "DEL" },
      { name: "Даммам", iata: "DMM" },
      { name: "Доха", iata: "DOH" },
      { name: "Дублин", iata: "DUB" },
      { name: "Дубай", iata: "DXB" },
      { name: "Флоренция", iata: "FLR" },
      { name: "Ханой", iata: "HAN" },
      { name: "Гонконг", iata: "HKG" },
      { name: "Пхукет", iata: "HKT" },
      { name: "Гонолулу", iata: "HNL" },
      { name: "Стамбул", iata: "IST" },
      { name: "Джайпур", iata: "JAI" },
      { name: "Джохор-Бару", iata: "JHB" },
      { name: "Джакарта", iata: "JKT" },
      { name: "Йоханнесбург", iata: "JNB" },
      { name: "Краков", iata: "KRK" },
      { name: "Куала-Лумпур", iata: "KUL" },
      { name: "Гуйлинь", iata: "KWL" },
      { name: "Лас-Вегас", iata: "LAS" },
      { name: "Лос-Анджелес", iata: "LAX" },
      { name: "Санкт-Петербург", iata: "LED" },
      { name: "Лима", iata: "LIM" },
      { name: "Лиссабон", iata: "LIS" },
      { name: "Лондон", iata: "LON" },
      { name: "Ченнай", iata: "MAA" },
      { name: "Мадрид", iata: "MAD" },
      { name: "Мельбурн", iata: "MEL" },
      { name: "Мехико", iata: "MEX" },
      { name: "Макао", iata: "MFM" },
      { name: "Майами", iata: "MIA" },
      { name: "Милан", iata: "MIL" },
      { name: "Москва", iata: "MOW" },
      { name: "Мюнхен", iata: "MUC" },
      { name: "Ницца", iata: "NCE" },
      { name: "Нью-Йорк", iata: "NYC" },
      { name: "Осака", iata: "OSA" },
      { name: "Париж", iata: "PAR" },
      { name: "Прага", iata: "PRG" },
      { name: "Паттайя", iata: "PYX" },
      { name: "Марракеш", iata: "RAK" },
      { name: "Родос", iata: "RHO" },
      { name: "Рио-де-Жанейро", iata: "RIO" },
      { name: "Рим", iata: "ROM" },
      { name: "Эр-Рияд", iata: "RUH" },
      { name: "Сеул", iata: "SEL" },
      { name: "Сан-Франциско", iata: "SFO" },
      { name: "Хошимин", iata: "SGN" },
      { name: "Шанхай", iata: "SHA" },
      { name: "Сингапур", iata: "SIN" },
      { name: "Стокгольм", iata: "STO" },
      { name: "Сидней", iata: "SYD" },
      { name: "Шэньчжэнь", iata: "SZX" },
      { name: "Тель-Авив", iata: "TLV" },
      { name: "Тайбэй", iata: "TPE" },
      { name: "Токио", iata: "TYO" },
      { name: "Венеция", iata: "VCE" },
      { name: "Вена", iata: "VIE" },
      { name: "Вашингтон", iata: "WAS" },
      { name: "Варшава", iata: "WAW" },
      { name: "Торонто", iata: "YTO" },
      { name: "Ванкувер", iata: "YVR" },
      { name: "Чжухай", iata: "ZUH" },
      { name: "Орландо", iata: "ORL" },
      { name: "Тайчжун", iata: "RMQ" }
    ]
  end

  def self.iata_include?(iata)
    call.select { |h| h[:iata] == iata }.present?
  end
end