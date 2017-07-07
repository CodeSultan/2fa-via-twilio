
class Order < ApplicationRecord

  belongs_to :user, optional: true
  validates :api_key, presence: true
  validates :api_secret_key, presence: true
  validates :amount, presence: true
  validates :order_name, presence: true, length: { maximum: 50 }


  CURRENCYPAIRS = [ ['XBT/EUR', 'XBTEUR'], ['XBT/USD', 'XBTUSD'], ['XBT/GBP', 'XBTGBP'],
                    ['DASH/EUR', 'DASHEUR'], ['DASH/USD', 'DASHUSD'],
                    ['ETC/EUR', 'ETCEUR'], ['ETC/USD', 'ETCUSD'],
                    ['ETH/EUR', 'ETHEUR'], ['ETH/USD', 'ETHUSD'], ['ETH/GBP', 'ETHGBP'],
                    ['GNO/EUR', 'GNOEUR'], ['GNO/USD', 'GNOUSD'],
                    ['LTC/EUR', 'LTCEUR'], ['LTC/USD', 'LTCUSD'],
                    ['REP/EUR', 'REPEUR'], ['REP/USD', 'REPUSD'],
  ]

  FREQUENCYTYPES = [ ["Daily", "daily"], ["Monthly", "monthly"], ["Yearly", 'yearly'] ]

  attr_encrypted :api_key, key: 'Dominik-Anatoly-Bittrex-Encrypt1', encode: true, encode_iv: true

  attr_encrypted :api_secret_key, key: 'Dominik-Anatoly-Bittrex-Encrypt1', encode: true, encode_iv: true

end

