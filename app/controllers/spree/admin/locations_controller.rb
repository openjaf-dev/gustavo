class Spree::Admin::LocationsController < Spree::Admin::ResourceController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /spree/admin/locations
  # GET /spree/admin/locations.json
  def index
    @locations = Spree::Location.all
  end

  # GET /spree/admin/locations/1
  # GET /spree/admin/locations/1.json
  def show
  end

  # GET /spree/admin/locations/new
  def new
    @location = Spree::Location.new
  end

  # GET /spree/admin/locations/1/edit
  def edit
  end

  # POST /spree/admin/locations
  # POST /spree/admin/locations.json
  def create
    @location = Spree::Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spree/admin/locations/1
  # PATCH/PUT /spree/admin/locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spree/admin/locations/1
  # DELETE /spree/admin/locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Spree::Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :location_name, :phone_number, :distric, :city, :postcode, :country, :lat, :lng, :reference, :enabled)
    end
end
