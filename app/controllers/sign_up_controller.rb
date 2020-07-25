# frozen_string_literal: true

class SignUpController < ApplicationController
  def new
    render :new, locals: { user: User::RegistrationForm.new }
  end

  def create
    RegisterUserCase
      .call(params: registration_params)
      .on_success(&method(:create_success))
      .on_failure(:validation_failure, &method(:create_failed))
      .on_failure(:exception, &method(:create_exception))
  end

  private

  def create_success(result)
    session[:user_id] = result.id.to_s
    redirect_to users_profile_path
  end

  def create_failed(user, _use_case)
    render :new, locals: { user: user }
  end

  def create_exception(exception, _use_case)
    flash.now[:error] = "Something went wrong... #{exception.message}"
    render :new, locals: { user: User::RegistrationForm.new(registration_params) }
  end

  def registration_params
    params
      .require(:user)
      .permit(:username, :email, :address, :email_confirmation, :agree_terms)
  end
end
