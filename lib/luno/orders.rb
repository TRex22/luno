module Luno
  module Orders
    def get_fee_information(maker:, taker:)
      path = "fee_info"
      pair = "#{maker}#{taker}".upcase

      # TODO: Validate pair from constants
      authorise_and_send(http_method: :get, path: path, params: { pair: pair })
    end

    def list_orders
      path = "list_orders"
      authorise_and_send(http_method: :get, path: path)
    end

    def list_trades
      path = "list_trades"
      authorise_and_send(http_method: :get, path: path)
    end
  end
end
