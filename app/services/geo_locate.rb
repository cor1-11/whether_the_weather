class GeoLocate < ApplicationService
  def initialize(data)
    @data = data
  end

  def call
    data = Geocoder.search(@data)[0].data
    { latitude: data['lat'], longitude: data['lon'] }
  end
end