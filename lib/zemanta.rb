require 'active_support/dependencies/autoload'
require 'typhoeus'
require 'json'
require 'digest/md5'

class Zemanta
  extend ActiveSupport::Autoload

  autoload :Cache
  autoload :Configuration
  autoload :Fetcher
  autoload :Markup

  def initialize(text)
    @text = text
  end

  def suggest_markup(opts = {})
    Markup.new(suggest_markup_request(opts))
  end


  # Usage:
  # Zemanta.configure do |config|
  #   You can pass a hash of custom options that will be passed into each request
  #   config.custom_request_opts = {target_types: "geolocation"}
  #
  #   If you prefer format other than json for some reason, go for it!
  #   config.format = "json"
  #     note: It won't work, currently there is no support for formats other than json.
  #
  #   You can cache Zemanta responses if you wish. You just need to pass any key => value store in here:
  #   config.cache_store = {}  # default is no caching
  #
  #   You can pass api_key to zemanta here
  #   config.api_key = "yourapikeyhere"
  # end
  def self.configure
    yield config
  end

  def self.config
    @configuration ||= Configuration.new
  end

  private

  def suggest_markup_request(opts)
    @response ||= request({ text: @text, method: "zemanta.suggest_markup" }.merge(opts))['markup']
  end

  def request(opts)
    Fetcher.new(opts).post
  end
end
