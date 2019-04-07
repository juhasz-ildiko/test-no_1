##
# Mock HTTP request to geocoding service.
#
module Geocoder
  module Lookup
    class Base
      private

      def fixture_exists?(filename)
        File.exist?(Rails.root.join('spec', 'fixtures', filename))
      end

      def read_fixture(file)
        filepath = Rails.root.join('spec', 'fixtures', file)
        s = File.read(filepath).strip.gsub(/\n\s*/, '')
        MockHttpResponse.new(body: s, code: '200')
      end

      ##
      # Fixture to use if none match the given query.
      #
      def default_fixture_filename
        "#{fixture_prefix}_madison_square_garden"
      end

      def fixture_prefix
        handle
      end

      def fixture_for_query(query)
        label = query.reverse_geocode? ? 'reverse' : query.text.gsub(/[ \.]/, '_')
        filename = "#{fixture_prefix}_#{label}"
        fixture_exists?(filename) ? filename : default_fixture_filename
      end

      # remove_method(:make_api_request)

      def make_api_request(query)
        raise Timeout::Error if query.text == 'timeout'
        raise SocketError if query.text == 'socket_error'
        raise Errno::ECONNREFUSED if query.text == 'connection_refused'
        if query.text == 'invalid_json'
          return MockHttpResponse.new(body: 'invalid json', code: 200)
        end

        read_fixture fixture_for_query(query)
      end
    end

    # require 'geocoder/lookups/google_premier'
    # class GooglePremier
    #   private

    #   def fixture_prefix
    #     'google'
    #   end
    # end

    # require 'geocoder/lookups/google_places_details'
    # class GooglePlacesDetails
    #   private

    #   def fixture_prefix
    #     'google_places_details'
    #   end
    # end
  end
end

class MockHttpResponse
  attr_reader :code, :body
  def initialize(options = {})
    @code = options[:code].to_s
    @body = options[:body]
    @headers = options[:headers] || {}
  end

  def [](key)
    @headers[key]
  end
end
