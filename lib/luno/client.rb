module Luno
  class Client
    include ::Luno::Constants

    # Endpoints
    include ::Luno::Accounts
    include ::Luno::Beneficiaries
    include ::Luno::Markets
    include ::Luno::Orders
    include ::Luno::Quotes
    include ::Luno::Receiving
    include ::Luno::Sending
    include ::Luno::Transactions
    include ::Luno::Withdrawals

    # Beta Endpoints
    include ::Luno::Lightning
    include ::Luno::Streaming

    # Custom Endpoints
    include ::Luno::OtherData

    attr_reader :key, :secret, :base_path, :port

    def initialize(key:, secret:, base_path: 'https://api.luno.com/api/1', port: 80)
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

    def unauthorised_and_send(http_method:, path:, payload: {}, params: {})
      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path, params),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_object(response, path, start_time, end_time)
    end

    def authorise_and_send(http_method:, path:, payload: {}, params: {})
      auth = {username: key, password: secret}

      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path, params),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        basic_auth: auth,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_object(response, path, start_time, end_time)
    end

    def construct_response_object(response, path, start_time, end_time)
      {
        'body' => parse_body(response, path),
        'headers' => response.headers,
        'metadata' => construct_metadata(response, start_time, end_time)
      }
    end

    def construct_metadata(response, start_time, end_time)
      total_time = end_time - start_time

      {
        'start_time' => start_time,
        'end_time' => end_time,
        'total_time' => total_time
      }
    end

    def body_is_present?(response)
      !body_is_missing?(response)
    end

    def body_is_missing?(response)
      response.body.nil? || response.body.empty?
    end

    def parse_body(response, path)
      parsed_response = JSON.parse(response.body) # Purposely not using HTTParty

      if parsed_response.dig(path.to_s)
        parsed_response.dig(path.to_s)
      else
        parsed_response
      end
    rescue JSON::ParserError => _e
      response.body
    end

    def get_micro_second_time
      (Time.now.to_f * 1000000).to_i
    end

    def construct_base_path(path, params)
      constructed_path = "#{base_path}/#{path}"

      if params == {}
        constructed_path
      else
        "#{constructed_path}?#{process_params(params)}"
      end
    end

    def process_params(params)
      params.keys.map { |key| "#{key}=#{params[key]}" }.join('&')
    end
  end
end
