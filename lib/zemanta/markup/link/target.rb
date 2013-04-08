class Zemanta
  class Markup
    class Link
      class Target
        attr_reader :url, :type, :title

        def initialize(opts = {})
          @url   = opts["url"]
          @type  = opts["type"]
          @title = opts["title"]
        end
      end
    end
  end
end