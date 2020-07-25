# frozen_string_literal: true

class User < ApplicationRecord
  thread_cattr_accessor :current
  enum role: %i[individual legal_entity moderator]

  validates :address, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false, allow_nil: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false, allow_nil: false }

  store_accessor :geodata, :latitude, :longitude

  geocoded_by :address
  before_save :geocode
end
