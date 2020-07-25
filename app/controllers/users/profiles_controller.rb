# frozen_string_literal: true

module Users
  class ProfilesController < ApplicationController
    def show
      render :show, locals: { user: user }
    end

    def edit
      render :edit, locals: { user: user }
    end

    def update
      UpdateUserProfileCase
        .call(params: profile_params, user: user)
        .on_success(&method(:update_success))
        .on_failure(:validation_failure, &method(:update_failed))
        .on_failure(:exception, &method(:update_exception))
    end

    private

    def update_success(_user)
      redirect_to edit_profile_path
    end

    def update_failed(user, _use_case)
      render :edit, locals: { user: user }
    end

    def update_exception(exception)
      flash.now[:error] = "Something went wrong... #{exception.message}"
      render :edit, locals: { user: user }
    end

    def user
      @user ||= User.current.becomes(User::ProfileForm)
    end

    def profile_params
      params
        .require(:user)
        .permit(:username, :email, :address, :email_confirmation, :agree_terms)
    end
  end
end
