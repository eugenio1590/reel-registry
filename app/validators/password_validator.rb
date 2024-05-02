class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid, message: "must include at least one uppercase letter") unless value =~ /[A-Z]/
    record.errors.add(attribute, :invalid, message: "must include at least one lowercase letter") unless value =~ /[a-z]/
    record.errors.add(attribute, :invalid, message: "must include at least one of the following characters: !, @, #, ?, or ]") unless value =~ /[!@#?\]]/
  end
end
