# frozen_string_literal: true
require 'faraday'
require "faraday_error/version"

module FaradayError
  autoload :Middleware, "faraday_error/middleware"

  def self.handlers
    @@handlers ||= {}
    @@handlers
  end
end

require 'faraday_error/newrelic'
require 'faraday_error/honeybadger'
