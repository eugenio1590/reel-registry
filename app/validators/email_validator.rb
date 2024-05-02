class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add(attribute, (options[:message] || "is not a valid email format"))
    end
  end
end
