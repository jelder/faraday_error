# frozen_string_literal: true

module FaradayError
  class Middleware

    MAX_PARSED_BODY_LENGTH = (1*1024*1024).freeze

    def initialize(app, options = {})
      @app = app
      @name = options.fetch(:name, 'faraday')
    end

    def call(env)
      set_context(@name => context_from_env(env))
      result = @app.call(env)
      return result
    end

    private

      def set_context(context = {})
        FaradayError.handlers.each_pair do |name, proc|
          proc.call(context)
        end
      end

      def context_from_env(env)
        body_length = String(env[:body]).length
        context = {
          method: env[:method],
          url: env[:url],
          request_headers: env[:request_headers],
          body_length: body_length,
        }
        if 2 < body_length && body_length < MAX_PARSED_BODY_LENGTH
          begin
            context[:body] = case env[:request_headers]["Content-Type"]
            when "application/json"                   then JSON.parse(env[:body])
            when "application/x-www-form-urlencoded"  then URI.decode_www_form(env[:body]).to_h
            end
          rescue => ex
            puts ex.inspect
            puts ex.backtrace
          ensure
            context[:body] ||= env[:body]
          end
        end
        return context
      end

  end
end