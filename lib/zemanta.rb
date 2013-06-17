require 'typhoeus'
require 'json'
require 'digest/md5'

require 'zemanta/cache'
require 'zemanta/cache/disk'
require 'zemanta/configuration'
require 'zemanta/configuration/null_storage'
require 'zemanta/fetcher'
require 'zemanta/fetcher/web'
require 'zemanta/fetcher/cache'
require 'zemanta/fetcher/cache/null_response'
require 'zemanta/fetcher/cache/response'
require 'zemanta/fetcher/cache/key'
require 'zemanta/markup'
require 'zemanta/markup/link'
require 'zemanta/markup/link/target'
require 'zemanta/enhancer'

class Zemanta
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