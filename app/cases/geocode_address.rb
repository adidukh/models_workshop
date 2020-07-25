# frozen_string_literal: true

class GeocodeAddress < Micro::Case::Strict
  attributes :params

  def call!
    Success(params: geocoded_params)
  end

  private

  def geocoded_params
    params.tap do |h|
      h[:longitude], h[:latitude] = geocoding_coordinates
    end
  end

  def geocoding_coordinates
    @geocoding_coordinates ||= Geocoder.coordinates(params.fetch(:address))
  end
end
