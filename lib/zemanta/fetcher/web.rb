class Zemanta
  class Fetcher
    class Web
      def initialize(opts = {})
        @opts = opts
      end

      def fetch
        if http_fetch == zemanta_error_response
          raise_api_key_exception!
        else
          http_fetch
        end
      end

      private

      def http_fetch
        @response ||= Typhoeus.post(url, params: @opts).response_body
      end

      def zemanta_error_response
        '<h1>403 Developer Inactive</h1>'
      end

      def raise_api_key_exception!
        raise "Zemanta returned '#{zemanta_error_response}' exception. Quite possibly you passed incorrect api_key."
      end

      def url
        Zemanta.config.end_point
      end
    end
  end
end