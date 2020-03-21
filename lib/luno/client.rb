module Luno
  class Client
    attr_reader :key, :secret, :base_path, :port

    def initialize(key:, secret:, base_path: 'https://api.mybitx.com/api/1', port: 80)
      @key = key
      @secret = secret
      @base_path = base_path
      @port = port
    end

    def list_accounts
      path = 'accounts'
      authorise_and_send(http_method: :get, path: path)
    end

    def market_top_100_bids(pair: 'XBTZAR')
      path = "orderbook_top?pair=#{pair}"
      unauthorised_and_send(http_method: :get, path: path)
    end

    def self.compatible_api_version
      'v1'
    end

    # This is the version of the API docs this client was built off-of
    def self.api_version
      'v1 2020-02-24'
    end

    private

    def unauthorised_and_send(http_method:, path:, payload: {})
      HTTParty.send(
        http_method.to_sym,
        construct_base_path(path),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        format: :json
      )
    end

    def authorise_and_send(http_method:, path:, payload: {})
      auth = {username: key, password: secret}

      HTTParty.send(
        http_method.to_sym,
        construct_base_path(path),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        basic_auth: auth,
        format: :json
      )
    end

    def construct_base_path(path)
      "#{base_path}/#{path}"
    end
  end
end
