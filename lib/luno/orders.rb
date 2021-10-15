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

    # TYPE = "BUY" "SELL"
    def create_market_order(
      pair:,
      type:,
      counter_volume: nil, # how much currency to use for a BUY order
      base_volume: nil, # how much crypto to use for a SELL order
      base_account_id: ,
      counter_account_id: ,
      ttl: 10000,
      client_order_id: nil)

      # TODO: Raise exception if counter_volume and base_volume are both nil
      path = 'marketorder'

      params = {
        pair: pair,
        type: type,
        base_account_id: base_account_id,
        counter_account_id: counter_account_id,
        ttl: ttl
      }

      params.merge({ counter_volume: counter_volume }) if counter_volume
      params.merge({ base_volume: base_volume }) if base_volume
      params.merge({ client_order_id: client_order_id }) if client_order_id

      authorise_and_send(http_method: :post, path: path, params: params)
    end

    # Currency pair trade
    # Type = "BID" or "ASK"
    # stop_direction: "BELOW" "ABOVE" "RELATIVE_LAST_TRADE"
    # TODO: Figure out
    def create_limit_order(
      pair:,
      type:,
      volume:,
      price:,
      post_only: nil,
      stop_price: nil,
      stop_direction: nil,
      base_account_id: nil,
      counter_account_id: nil,
      ttl: 10000,
      client_order_id: nil)
      path = 'postorder'

      params = {
        pair: pair,
        type: type,
        volume: volume,
        price: price,
        ttl: ttl
      }

      params.merge({ post_only: post_only }) if post_only
      params.merge({ stop_price: stop_price }) if stop_price
      params.merge({ stop_direction: stop_direction }) if stop_direction
      params.merge({ base_account_id: base_account_id }) if base_account_id
      params.merge({ counter_account_id: counter_account_id }) if counter_account_id
      params.merge({ client_order_id: client_order_id }) if client_order_id

      authorise_and_send(http_method: :post, path: path, params: params)
    end

    def cancel_order(order_id:)
      path = 'stoporder'
      authorise_and_send(http_method: :post, path: path, params: { order_id: order_id })
    end
  end
end
