module Luno
  module Accounts
    def list_accounts
      path = 'accounts'
      authorise_and_send(http_method: :get, path: path)
    end

    def market_top_100_bids(pair: 'XBTZAR')
      path = "orderbook_top?pair=#{pair}"
      unauthorised_and_send(http_method: :get, path: path)
    end
  end
end