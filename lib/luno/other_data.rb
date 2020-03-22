# These are not official API endpoints for Luno.
# Rather this is data taken from the Luno website and parsed into JSON

module Luno
  module OtherData
    def ping(limit: 4, paths: ['https://www.luno.com/', 'https://api.mybitx.com/api/1/'])
      endpoint_metrics = paths.map do |path|
        responses = []

        limit.times do
          responses << unauthorised_and_send(http_method: :get, path: path)
        end

        avg_time = responses
          .map { |r| r.dig(:metadata)&.dig(:total_time) }
          .reduce(&:+) / limit

        {
          path: path,
          average_time: avg_time
        }
      end

      {
        metadata: {
          endpoint_metrics: endpoint_metrics
        }
      }
    end
  end
end