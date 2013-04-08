class Zemanta
  class Fetcher
    extend ActiveSupport::Autoload

    autoload :Cache
    autoload :Web

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
      JSON.parse(data)
    end

    def request_opts
      @request_opts ||= Zemanta.config.request_opts.merge(@opts)
    end
  end
end
