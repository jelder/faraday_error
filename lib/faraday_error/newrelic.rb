if Kernel.const_defined?("NewRelic")
  FaradayError.handlers[:newrelic] ||= -> (context) { NewRelic::Agent.add_custom_attributes(context) }
end
