# FaradayError
[![Gem Version](https://badge.fury.io/rb/faraday_error.svg)](https://badge.fury.io/rb/faraday_error)

A [Faraday](https://github.com/lostisland/faraday) middleware for adding request parameters to your exception tracker.

### Supports
 - [Honeybadger](https://www.honeybadger.io/)
 - [NewRelic](http://newrelic.com/)
 - Your favorite thing, as soon as you make a pull request!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday_error'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday_error

## Usage

Configure your Faraday connection to use this middleware. You can optionally specify a name; defaults to `faraday`. It is expected that you also use `Faraday::Response::RaiseError` somewhere in your stack.
```ruby
connection = Faraday.new(url: 'http://localhost:4567') do |faraday|
  faraday.use       FaradayError::Middleware, name: "example_request"
  faraday.use       Faraday::Response::RaiseError
  faraday.adapter   Faraday.default_adapter
end
```

And that's it. Make a request as you normally would.
```ruby
connection.post do |req|
  req.url '/503'
  req.headers['Content-Type'] = 'application/json'
  req.body = JSON.generate(abc: "xyz")
end
```

If any request fails, Honeybadger's "context" for this error will include your request parameters. If sending JSON or `application/x-www-form-urlencoded`, these will be included in parsed form.
```json
{
  "example_request": {
    "method": "post",
    "url": "http://localhost:4567/503",
    "request_headers": {
      "User-Agent": "Faraday v0.9.2",
      "Content-Type": "application/json"
    },
    "body_length": 13,
    "body": {
      "abc": "xyz"
    }
  }
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

The included [RestReflector](../spec/rest_reflector.rb) Sinatra app is suitable for making requests that are guaranteed to fail in particlar ways.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jelder/faraday_error. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

