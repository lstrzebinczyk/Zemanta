module Zemanta
  class Fetcher
    class Cache
      def initialize(opts = {})
        @key = Key.new(opts).to_s
      end

      def fetch
        fetch_from_storage(@key).to_s
      end

      def save(response)
        storage[@key] = Response.new(response) unless storage[@key]
      end

      private

      def storage
        Zemanta.config.cache_storage
      end

      def fetch_from_storage(opts)
        storage[@key] || NullResponse.new
      end
    end
  end
end