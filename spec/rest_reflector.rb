require 'sinatra/base'
require 'pry'

class RestReflector < Sinatra::Base
  %i[
    delete
    get
    link
    options
    patch
    post
    put
    unlink
  ].each do |http_verb|
    send(http_verb, %r{^/(\d{3})$}) do
      if (code = params[:captures].first.to_i) && code <= 599
        status code
      else
        body "RTFC"
      end
    end
  end

  run! if app_file == $0
end
