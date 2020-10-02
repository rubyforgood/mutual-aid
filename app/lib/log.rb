module Log
  # The ruby Logger::Formatter will log an Exception's backtrace but
  # ActiveSupport::Logger::SimpleFormatter overrides this behavior,
  # logging only the Exception's message. We _should_ be able to
  # configure the rails logger with our own formatter, but that
  # appears to take considerable finagling.
  def self.error exception, preamble = nil
    lines = [
      preamble,
      "#{exception.message} (#{exception.class})",
      *Rails.backtrace_cleaner.clean(exception.backtrace),
    ]

    Rails.logger.error lines.compact.join("\n")
  end
end
