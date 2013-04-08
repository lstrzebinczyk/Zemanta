class Zemanta
  module Cache
    class Disk
      attr_accessor :db

      def initialize(directory='tmp/db')
        @db = Pathname.new(directory)
        @db.mkpath
      end

      def [](key)
        file = @db.join(key)
        file.read if file.exist?
      end

      def []=(key,value)
        @db.join(key).open('w') {|f| f.write(value.to_s)}
      end
    end
  end
end
