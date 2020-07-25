# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    render :new, locals: { registration: User::Registration.new }
  end

  def create
    CreateRegistrationCase
      .call(params: registration_params)
      .on_success(&method(:create_success))
      .on_failure(:validation_failed, &method(:create_failed))
      .on_failure(:exception, &method(:create_exception))
  end

  private

  def create_success(result)
    session[:user_id] = result[:registration].id.to_s
    redirect_to users_profile_path
  end

  def create_failed(registration, _use_case)
    render :new, locals: { registration: registration }
  end

  def create_exception(exception, _use_case)
    binding.irb
    flash.now[:error] = 'Something went wrong...'
    render :new, locals: { registration: User::Registration.new(registration_params) }
  end

  def registration_params
    params
      .require(:user)
      .permit(:username, :email, :address, :email_confirmation, :agree_terms)
  end
end
