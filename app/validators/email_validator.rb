class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || value.strip.empty?
    unless /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.match?(value)
      record.errors.add attribute, (options[:message] || "is not valid")
    end
  end
end
