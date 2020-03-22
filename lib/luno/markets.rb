module Luno
  module Markets
    def market_top_100_bids(pair: 'XBTZAR')
      path = "orderbook_top?pair=#{pair}"
      unauthorised_and_send(http_method: :get, path: path)
    end
  end
end