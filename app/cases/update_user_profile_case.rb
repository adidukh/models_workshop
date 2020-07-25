# frozen_string_literal: true

class UpdateUserProfileCase < Micro::Case::Strict
  flow GeocodeAddress,
       self

  attributes :params, :user

  def call!
    return Success(user) if user.update(params)

    Failure(:validation_failure) { user }
  end
end
