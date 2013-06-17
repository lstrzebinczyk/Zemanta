module Zemanta
  class Fetcher
    def initialize(opts = {})
      @opts = opts
    end

    def post
      @response = cache.fetch || web.fetch
      cache.save(@response)
      parse(@response)
    end

    private

    def cache
      @cache ||= Cache.new(@opts)
    end

    def web
      Web.new(request_opts)
    end

    def parse(data)
      Parser.new(data).parse
    end

    def request_opts
      @request_opts ||= Zemanta.config.request_opts.merge(@opts)
    end
  end
end
