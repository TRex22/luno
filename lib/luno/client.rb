module Luno
  class Client

    attr_reader :key, :secret, :base_path

    def initialize(key:, secret:, base_path: 'https://api.mybitx.com/api/1/')
      @key = key
      @secret = secret
      @base_path = base_path
    end

    def self.compatible_api_version
      'V1'
    end
  end
end
