require 'oas_parser'

module Luno
  class Client

    attr_reader :definition, :paths, :endpoints

    def initialize(key:, secret:, openapi_path: './lib/swagger.json')
      @definition = OasParser::Definition.resolve(openapi_path)
      @paths = @definition.paths
      @endpoints = @definition.endpoints

      # # => #<OasParser::Definition>

      # # Get a specific path
      # path = definition.path_by_path('/pets')
      # # => #<OasParser::Path>

      # # Get all paths.
      # definition.paths
      # # => [#<OasParser::Path>, ...]

      # # Get a specific endpoint by method
      # endpoint = path.endpoint_by_method('get')
      # # => #<OasParser::Endpoint>

      # # Get all endpoints
      # path.endpoints
      # # => [#<OasParser::Endpoint>, ...]

      # # Get endpoint description
      # endpoint.description
      # # => "Returns all pets from the system that the user has access to"
    end
  end
end
