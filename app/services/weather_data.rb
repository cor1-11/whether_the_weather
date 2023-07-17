class WeatherData < ApplicationService
  require 'rest-client'

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
    @forecast_data = {}
  end

  def call
    return @forecast_data unless @latitude && @longitude

    forecast_url = JSON.parse(RestClient.get("https://api.weather.gov/points/#{@latitude},#{@longitude}").body)['properties']['forecast']
    noaa_data = JSON.parse(RestClient.get(forecast_url).body)
    for d in 0..13 do
      @forecast_data[d] = {
        temp: noaa_data['properties']['periods'][d]['temperature'],
        temp_unit: noaa_data['properties']['periods'][d]['temperatureUnit'],
        daytime: noaa_data['properties']['periods'][d]['isDaytime'],
        condition: noaa_data['properties']['periods'][d]['shortForecast']
      }
    end

    @forecast_data
  end
end