class Zemanta
  class Fetcher
    class Cache
      class Response
        def initialize(data)
          @data = data
          @created_at = Time.now
        end

        def to_s
          @data
        end
      end
    end
  end
end