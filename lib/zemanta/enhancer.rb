module Zemanta
  class Enhancer
    # Options:
    #
    #  no_duplicates (default: false) - ensures links are used once
    #
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
        if @opts[:no_duplicates]
          @text.sub!(dictionary[:word], link)
        else
          @text.gsub!(dictionary[:word], link)
        end
      end
    end

    def words_to_anchor(opts)
      suggest_markup(opts).links.map do |link|
        { word: link.anchor, link: link.target.first.url }
      end
    end

    def suggest_markup(opts = {})
      Markup.fetch(@text, opts)
    end
  end
end
