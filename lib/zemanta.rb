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
