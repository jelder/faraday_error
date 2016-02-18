module FaradayError
  class Middleware

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
        context = {
          method: env[:method],
          url: env[:url],
          request_headers: env[:request_headers],
          body_length: env[:body].length
        }
        case env[:request_headers]["Content-Type"]
        when "application/json"
          context[:body] = JSON.parse(env[:body])
        when "application/x-www-form-urlencoded"
          context[:body] = URI.decode_www_form(env[:body]).to_h
        end
        return context
      end

  end
end