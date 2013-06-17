module Zemanta
  class Markup
    attr_reader :text, :links

    def initialize(opts = {})
      @text  = opts["text"]
      @links = opts["links"].map{ |link| Link.new(link) }
    end

    def self.fetch(text, opts = {})
      relevance  = opts.delete(:relevance)  || 0
      confidence = opts.delete(:confidence) || 0

      new(suggest_markup_request(text, opts)).tap do |markup|
        markup.drop_links_below(relevance, confidence)
      end
    end

    def drop_links_below(relevance, confidence)
      @links.keep_if do |link|
        link.above?(relevance, confidence)
      end
    end

    private

    def self.suggest_markup_request(text, opts)
      return {'links' => []} if text.to_s.empty?
      request({ text: text, method: "zemanta.suggest_markup" }.merge(opts))["markup"]
    end

    def self.request(opts)
      Fetcher.new(opts).post
    end
  end
end