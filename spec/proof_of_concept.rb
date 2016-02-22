require 'honeybadger'

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_error'

Honeybadger.start(Honeybadger::Config.new(env: "development", report_data: true, debug: true))

begin
  connection = Faraday.new(url: 'http://localhost:4567') do |faraday|
    faraday.use       Faraday::Response::RaiseError
    faraday.use       FaradayError::Middleware, name: "example_request"
    faraday.adapter   Faraday.default_adapter
  end

  connection.get do |req|
    req.url '/503'
    req.headers['Content-Type'] = 'application/json'
    # req.body = JSON.generate(abc: "xyz")
  end

  connection.post do |req|
    req.url '/503'
    req.headers['Content-Type'] = 'application/json'
    req.body = JSON.generate(abc: "xyz")
  end
rescue => ex
  Honeybadger.notify(ex)
end

Honeybadger.flush
