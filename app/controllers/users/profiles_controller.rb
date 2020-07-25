# frozen_string_literal: true

module Users
  class ProfilesController < ApplicationController
    def show
      render :show, locals: { profile: profile }
    end

    def edit
      render :edit, locals: { profile: profile }
    end

    def update
      if profile.update(profile_params)
        redirect_to edit_profile_path
      else
        render :edit, locals: { profile: profile }
      end
    end

    private

    def profile
      @profile ||= User.current.becomes(User::Profile)
    end

    def profile_params
      params
        .require(:user)
        .permit(:username, :email, :address, :email_confirmation, :agree_terms)
    end
  end
end
