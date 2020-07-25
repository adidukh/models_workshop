# frozen_string_literal: true

class RegisterUserCase < Micro::Case::Strict::Safe
  flow GeocodeAddress,
       self

  attributes :params



  def call!
    user = User::RegistrationForm.new(params)

    return Success(user) if user.save

    Failure(:validation_failure) { user }
  end
end
