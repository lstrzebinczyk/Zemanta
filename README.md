# Zemanta

This is a ruby client to awesome Zemanta app. 

## Installation

Add this line to your application's Gemfile:

    gem 'zemanta_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zemanta_client

## Api key

You need to set api_key to use the client. If you won't do that, gem will raise an error. There are 2 ways:

  1. Environment variable
    - Set `ZEMANTA_KEY` key in you environment variables and gem will use it

  2. Configuration
    - You can set your api_key in configuration block like this:

      ```ruby
        Zemanta.configure { |c| c.api_key = 'your_api_key' } 
      ```


## Usage

Two use cases are implemented: 
  
  1. Retrieving suggest_markup data and enhancing the text.

    ```ruby
    Zemanta::Markup.fetch(text, opts = {})
    ```
    
    It will fetch suggest_markup data for passed text from Zemanta api and wrap it in custom classes.

  
  2. Enhancing the text with links:
  
    ```ruby
    Zemanta::Enhancer.new(text, opts = {}).enhance
    ```
  
    It will fetch suggest_markup data for given text and for every returned link it will wrap the keyword with this link.
    Then it will return the updated text.

In both relevance and confidence keys can be passes inside opts to filter any links that are below passed values.

## Configuration

There are several configuration options you can set:

```ruby
Zemanta.configure do |config|
  # You can pass a hash of custom options that will be passed into each request. It's empty by default.
  config.custom_request_opts = {}

  # Zemanta supports various response formats. However, this client works only with json, so changing this would be rather bad idea.
  config.format = "json"

  # This client supports caching, details below. Default is no caching.
  config.cache_store = Zemanta::Configuration::NullStorage

  # You can pass api_key to zemanta, as described above.
  config.api_key = "yourapikeyhere"
end
```

## Caching

  By default there is no caching. You can pass any cache store to `config.cache_store` in configuration.
  The only expectation is that it answers to `[]` and `[]=` methods. For example, you can pass ruby hash or `Cache::Disk.new`
  object to use simple file system storage.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

0.0.4 - fixed yajl require in gemspec
0.0.3 - Added Enhancer class, used yajl for json parsing, changed external gem api.
0.0.2 - Got rid of autoloads.
0.0.1 - Initial release. Support for suggest_markup method and caching.
