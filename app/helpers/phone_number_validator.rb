module PhoneNumberValidator
  def valid_phone_number(attribute)
    phone_number = send(attribute)
    unless Phonelib.valid?("+91#{phone_number}")
      errors.add(attribute, "Invalid or Unrecognized Contact Number") if phone_number.present?
    end
  end
end
