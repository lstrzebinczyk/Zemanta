class Zemanta
  class Enhancer
    def initialize(text, opts = {})
      @text = text
      @opts = opts
    end

    def enhance
      enhance!
      @text
    end

    private

    def enhance!
      words_to_anchor(@opts).each do |dictionary|
        link = "<a href=#{dictionary[:link]}>#{dictionary[:word]}</a>"
        @text.gsub!(dictionary[:word], link)
      end
    end

    def words_to_anchor(opts)
      suggest_markup(opts).links.map do |link|
        { word: link.anchor, link: link.target.first.url }
      end
    end

    def suggest_markup(opts = {})
      Markup.new(suggest_markup_request(opts))
    end

    def suggest_markup_request(opts)
      @response ||= request({ text: @text, method: "zemanta.suggest_markup" }.merge(opts))['markup']
    end

    def request(opts)
      Fetcher.new(opts).post
    end
  end
end