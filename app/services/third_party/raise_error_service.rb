module ThirdParty::RaiseErrorService
  def self.call(klass, data = nil, raise_flag = false)
    # exception types: [:raise, :abort]
    error = data['error'] || data['message'] || data['error_message']

    return if error.nil?

    logger = Logger.new(STDOUT)
    error_message = "#{klass} | #{error}"
    logger.warn(error_message)

    raise error_message if raise_flag
  end
end
