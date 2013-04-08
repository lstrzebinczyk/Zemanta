class Zemanta
  class Markup
    extend ActiveSupport::Autoload

    autoload :Link

    attr_reader :text, :links

    def initialize(opts = {})
      @text  = opts["text"]
      @links = opts["links"].map{ |link| Link.new(link) }
    end
  end
end