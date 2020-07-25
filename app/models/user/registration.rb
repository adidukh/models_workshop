# frozen_string_literal: true

class User < ApplicationRecord
  class Registration < ::User
    include ApplicationShape

    validates :email, confirmation: { case_sensitive: false }
    validates :agree_terms, acceptance: { allow_nil: false }
  end
end
