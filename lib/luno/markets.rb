module Luno
  module Markets
    def market_top_100_bids(pair: 'XBTZAR')
      path = "orderbook_top?pair=#{pair}"
      unauthorised_and_send(http_method: :get, path: path)
    end

    def list_ticker_for_pair(pair:)
      path = 'ticker'
      authorise_and_send(http_method: :get, path: path, params: { pair: pair })
    end

    def list_tickets_for_all_pairs
      path = 'tickers'
      authorise_and_send(http_method: :get, path: path)
    end
  end
end
