module Zemanta
  class Configuration
    attr_accessor :custom_request_opts, :format, :api_key, :cache_storage,
                  :character_limit

    def initialize
      @custom_request_opts = {}
      @format = "json"
      @cache_storage = NullStorage.new
    end

    def request_opts
      {
        api_key: actual_api_key,
        format: @format
      }.merge(@custom_request_opts)
    end

    def end_point
      "http://api.zemanta.com/services/rest/0.0/"
    end

    private

    def actual_api_key
      @api_key || ENV["ZEMANTA_KEY"] or raise "You need to specify ZEMANTA_KEY in your environment or set api_key in your config"
    end
  end
end
