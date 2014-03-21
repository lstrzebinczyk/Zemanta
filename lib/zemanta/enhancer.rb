module Zemanta
  class Enhancer
    # Options:
    #
    #  no_duplicates (default: false) - ensures links are used once
    #  skip - regexp for URLs not to be hot-linked
    #  strip_query_string - remove the query string from urls
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
        url = dictionary[:link]

        if @opts[:skip]
          next if url =~ @opts[:skip]
        end

        url = strip_query_string(url) if @opts[:strip_query_string]

        link = "<a href='#{url}'>#{dictionary[:word]}</a>"
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

    def strip_query_string(url)
      return nil unless url
      url.gsub(/\?.*$/, '')
    end
  end
end
