class Zemanta
  class Fetcher
    class Web
      def initialize(opts = {})
        @opts = opts
      end

      def fetch
        Typhoeus.post(url, params: @opts).response_body
      end

      private

      def url
        Zemanta.config.end_point
      end
    end
  end
end