# frozen_string_literal: true

class SignInController < ApplicationController
  def new
    user = User.new
    render :new, locals: { user: user }
  end

  def create
    if (user = User.find_by(email: session_params[:email].downcase))
      create_success(user)
    else
      create_failed
    end
  end

  private

  def create_failed
    flash.now[:error] = 'Wrong email'
    render :new, locals: { user: User.new(session_params) }
  end

  def create_success(user)
    session[:user_id] = user.id.to_s
    redirect_to users_profile_path
  end

  def session_params
    params
      .require(:user)
      .permit(:email)
  end
end
