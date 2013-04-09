# Zemanta

This is a ruby client to awesome Zemanta app. At this point it only supports suggest_markup method and is tested on ruby 1.9.3.

## Installation

Add this line to your application's Gemfile:

    gem 'zemanta_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zemanta_client

## Usage

You need to set api_key to use the client. If you won't do that, gem will raise an error. There are 2 ways:
  1. Environment variable
    - Set ZEMANTA_KEY key in you environment variables and gem will use it

  2. Configuration
    - You can set your api_key in configuration block like this:
    - Zemanta.configure { |c| c.api_key = 'your_api_key' } 

After your api_key has been set, all you need to do is:

    Zemanta.new("Text you want to send to Zemanta").suggest_markup

And you will be returned Markup object or error will be raised if Zemanta returns one.

## Configuration

  There are several configuration options you can set:

      Zemanta.configure do |config|
        You can pass a hash of custom options that will be passed into each request. It's empty by default.
        config.custom_request_opts = {}
      
        Zemanta supports various response formats. However, this client works only with json, so changing this would be rather bad idea.
        config.format = "json"
      
        This client supports caching, details below. Default is no caching.
        config.cache_store = Zemanta::Configuration::NullStorage
      
        You can pass api_key to zemanta, as described above.
        config.api_key = "yourapikeyhere"
      end

## Caching
  By default there is no caching. You can pass any cache store to config.cache_store in configuration.
  The only expectation is that it answers to [] and []= methods. For example, you can pass ruby hash or Cache::Disk.new
  object to use simple file system storage.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

0.0.2 - Got rid of autoloads.
0.0.1 - Initial release. Support for suggest_markup method and caching.