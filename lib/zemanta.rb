require 'typhoeus'
require 'json'
require 'digest/md5'

require 'zemanta/cache/disk'
require 'zemanta/configuration'
require 'zemanta/configuration/null_storage'
require 'zemanta/fetcher'
require 'zemanta/fetcher/parser'
require 'zemanta/fetcher/web'
require 'zemanta/fetcher/cache'
require 'zemanta/fetcher/cache/null_response'
require 'zemanta/fetcher/cache/response'
require 'zemanta/fetcher/cache/key'
require 'zemanta/markup'
require 'zemanta/markup/link'
require 'zemanta/markup/link/target'
require 'zemanta/enhancer'

module Zemanta
  def self.configure
    yield config
  end

  def self.config
    @configuration ||= Configuration.new
  end
end