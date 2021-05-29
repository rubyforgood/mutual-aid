class EmailValidator < ActiveModel::Validator
  REGEX_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  def validate(record)
    options[:fields].each { |field| validate_email(record, field) } if options[:fields].any?
  end

  private

  def validate_email(record, field)
    value = record.send(field)
    record.errors.add field, (options[:message] || "is not valid") if !value.nil? && !value.strip.empty? && !REGEX_EMAIL.match?(value)
  end
end
