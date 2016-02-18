if Kernel.const_defined?("Honeybadger")
  FaradayError.handlers[:honeybadger] ||= -> (context) { Honeybadger.context(context) }
end

