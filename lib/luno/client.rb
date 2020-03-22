module Luno
  class Client
    # Endpoints
    include ::Luno::Accounts
    include ::Luno::Beneficiaries
    include ::Luno::Markets
    include ::Luno::Orders
    include ::Luno::Quotes
    include ::Luno::Recieving
    include ::Luno::Sending
    include ::Luno::Transactions
    include ::Luno::Withdrawals

    # Beta Endpoints
    include ::Luno::Lightning
    include ::Luno::Streaming

    # Custom
    include ::Luno::OtherData

    attr_reader :key, :secret, :base_path, :port

    def initialize(key:, secret:, base_path: 'https://api.mybitx.com/api/1', port: 80)
      @key = key
      @secret = secret
      @base_path = base_path
      @port = port
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
      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_obejct(response, start_time, end_time)
    end

    def authorise_and_send(http_method:, path:, payload: {})
      auth = {username: key, password: secret}

      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        basic_auth: auth,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_obejct(response, start_time, end_time)
    end

    def construct_response_obejct(response, start_time, end_time)
      response.to_json.merge({
        metadata: construct_metadata(start_time, end_time)
      })
    end

    def construct_metadata(start_time, end_time)
      total_time = end_time - start_time

      {
        start_time: start_time,
        end_time: end_time,
        total_time: total_time
      }
    end

    def get_micro_second_time
      (Time.now.to_f * 1000000).to_i
    end

    def construct_base_path(path)
      "#{base_path}/#{path}"
    end
  end
end
