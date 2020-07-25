# frozen_string_literal: true

class User < ApplicationRecord
  class Profile < ::User
    include ApplicationShape

    validates :email, confirmation: { case_sensitive: false }
  end
end
