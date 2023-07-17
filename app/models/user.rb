class User < ApplicationRecord
  attr_accessor :latitude, :longitude

  has_many :locations
  
  geocoded_by :ip,
    latitude: :latitude, longitude: :longitude
  after_find :geocode

  def primary_location
    locations.find_by(primary: true)
  end

  def other_locations
    locations.find_by(primary: false)
  end
end
