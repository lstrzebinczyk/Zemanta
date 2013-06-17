class Zemanta
  class Markup
    attr_reader :text, :links

    def initialize(opts = {})
      @text  = opts["text"]
      @links = opts["links"].map{ |link| Link.new(link) }
    end

    def self.fetch(text, opts = {})
      new(suggest_markup_request(text, opts))
    end

    private

    def self.suggest_markup_request(text, opts)
      request({ text: text, method: "zemanta.suggest_markup" }.merge(opts))["markup"]
    end

    def self.request(opts)
      Fetcher.new(opts).post
    end
  end
end