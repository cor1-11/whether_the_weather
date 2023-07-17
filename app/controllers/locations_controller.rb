class LocationsController < ApplicationController
  before_action :set_location
  helper_method :set_weather_data

  # GET /locations or /locations.json
  def index
    @locations = @current_user.other_locations
  end

  # GET /locations/1 or /locations/1.json
  def show
    set_weather_data(@location)
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = @current_user.locations.new(location_params)

    unless @location.save
      render partial: '/shared/error', locals: {object: @location}
      return
    end

    if @location.zip.present?
      @location.update(GeoLocate.call(@location.zip))
    elsif @location.ip_address.present?
      @location.update(GeoLocate.call(@location.ip_address))
    end
    set_weather_data(@location)
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_weather_data(location)
    @weather_data = WeatherData.call(location.latitude, location.longitude).reject{ |d| d[:start_time].hour < 6 }
    @weather_chart_data = {high: [], low: []}
    @weather_data.map{ |w| @weather_chart_data[w[:high_low].to_sym] << {w[:start_time].to_date => w[:temp] } }
    @weather_calendar_data = @weather_data.group_by{ |w| w[:start_time].to_date }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      puts 'setting location'
      return if @location = Location.find(params[:id] || @current_user.primary_location.id)

      puts 'creating location'
  
      @location = Location.create(user: @current_user, primary: true, latitude: @current_user.latitude, longitude: @current_user.longitude)
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:ip_address, :address_1, :address_2, :city, :state, :zip, :country, :latitude, :longitude, :primary)
    end
end
