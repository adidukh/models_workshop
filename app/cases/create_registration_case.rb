# frozen_string_literal: true

class CreateRegistrationCase < Micro::Case::Strict::Safe
  attributes :params

  def call!
    registration = User::Registration.new(params)

    return Success(registration: registration) if registration.save

    Failure(:validation_failed) { registration }
  end
end
