# These are not official API endpoints for Luno.
# Rather this is data taken from the Luno website and parsed into JSON

module Luno
  module OtherData
    COUNTRY_ENDPOINT = 'https://www.luno.com/en/countries'
    DOCUMENTATION_ENDPOINT = 'https://www.luno.com/en/developers/api'

    def ping(limit: 4, paths: ['https://www.luno.com/', 'https://api.mybitx.com/api/1/'])
      endpoint_metrics = paths.map do |path|
        responses = []

        limit.times do
          responses << unauthorised_and_send(http_method: :get, path: path)
        end

        avg_time = responses
          .map { |r| r.dig('metadata')&.dig('total_time') }
          .reduce(&:+) / limit

        {
          'path' => path,
          'average_time' => avg_time
        }
      end

      {
        'metadata' => {
          'endpoint_metrics' => endpoint_metrics
        }
      }
    end

    # TODO
    def countries
      response = call_countries
    end

    # From API Documentation
    # [WIP]
    def currencies
      lines = []

      response = call_api_documentation

      output = parse_html(response['body'])
        .at('div#tag\/Currency')
        .search('li')
        .map(&:text)
        .map { |text| text.split.join(" ") }

      {
        'body' => output,
        'headers' => response['headers'],
        'metadata' => response['metadata']
      }
    end

    # TODO
    def permissions
      response = call_api_documentation
    end

    def changelog
      lines = []

      response = call_api_documentation

      parse_html(response['body'])
        .at('div#tag\/Changelog')
        .search('li')
        .map(&:text)
        .map { |text| text.split.join(" ") }
        .map { |text|
          if (text[10] != ':' || unable_to_parse_time(text[0,10])) # ':' is at character 10
            lines[-1] = "#{lines[-1]}\n#{text}"
          else
            lines << text
          end
        }

      output = {}

      lines.each do |line|
        tuple = line.split(':')
        text = tuple[1, lines.size].join(':')
        key = tuple[0]

        output.merge!(key => text)
      end

      {
        'body' => output,
        'headers' => response['headers'],
        'metadata' => response['metadata']
      }
    end

    private

    def call_countries
      start_time = get_micro_second_time

      response = HTTParty.get(COUNTRY_ENDPOINT)

      end_time = get_micro_second_time
      construct_response_obejct(response, start_time, end_time)
    end

    def call_api_documentation
      start_time = get_micro_second_time

      response = HTTParty.get(DOCUMENTATION_ENDPOINT)

      end_time = get_micro_second_time
      construct_response_obejct(response, start_time, end_time)
    end

    def parse_html(raw_html)
      Nokogiri::HTML(raw_html)
    end

    def unable_to_parse_time(str)
      !parse_time(str)
    end

    def parse_time(str)
      Time.parse(str)
    rescue ArgumentError => _e
      false
    end
  end
end