module Zemanta
  class Fetcher
    class Parser
      def initialize(json)
        @json = json
      end

      def parse
        JSON.parse(@json)
      end
    end
  end
end