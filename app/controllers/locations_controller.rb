class LocationsController < ApplicationController
  before_action :set_location

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @weather_data = WeatherData.call(@location.latitude, @location.longitude).reject{ |d| d[:start_time].hour < 6 }
    @weather_chart_data = {high: [], low: []}
    @weather_data.map{ |w| @weather_chart_data[w[:high_low].to_sym] << {w[:start_time].to_date => w[:temp] } }
    @weather_calendar_data = @weather_data.group_by{ |w| w[:start_time].to_date }
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
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      puts 'setting location'
      return if @location = @current_user.primary_location

      puts 'creating location'
  
      @location = Location.create(user: @current_user, primary: true, latitude: @current_user.latitude, longitude: @current_user.longitude)
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:ip_address, :address_1, :address_2, :city, :state, :zip, :country, :latitude, :longitude)
    end
end
