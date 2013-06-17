module Zemanta
  class Configuration
    class NullStorage
      def [](key)
        nil
      end

      def []=(key,value)
      end
    end
  end
end
