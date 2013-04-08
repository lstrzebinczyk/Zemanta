class Zemanta
  class Fetcher
    class Cache
      class Key
        def initialize(value)
          @value = value
        end

        def to_s
          if @value.is_a?(String)
            digest(@value)
          elsif @value.is_a?(Hash)
            digest(@value.sort.to_s)
          else
            raise "You are trying to use #{@value.class} as cache key. Only Strings and Hashes are supported."
          end
        end

        private

        def digest(value)
          Digest::MD5.hexdigest(value)
        end
      end
    end
  end
end