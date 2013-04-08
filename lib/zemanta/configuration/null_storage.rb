class Zemanta
  class Configuration
    class NullStorage
      def fetch
        nil
      end

      def method_missing(*args)
        nil
      end

      def save(response)
      end
    end
  end
end
