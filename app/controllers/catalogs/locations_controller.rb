class Catalogs::LocationsController < ApplicationController
  before_action :set_catalogs_location, only: [:show, :edit, :update, :destroy]

  # GET /catalogs/locations
  # GET /catalogs/locations.json
  def index
    @aux = 'notnil'
    if admin_signed_in?
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
      if params[:codigo].nil? || params[:codigo].empty?
        @catalogs_locations = Catalogs::Location.all.paginate(page: params[:page], per_page: 10)
      else
        #@catalogs_suppliers.where(business_name: params[:codido])
        @catalogs_locations= Catalogs::Location.where("department LIKE :codigo or responsible LIKE :codigo or email LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 10)
      end
    else
    	redirect_to new_admin_session_path
    end
  end

  # GET /catalogs/locations/1
  # GET /catalogs/locations/1.json
  def show
  end

  # GET /catalogs/locations/new
  def new
    @catalogs_location = Catalogs::Location.new
    @eureka = nil
  end

  # GET /catalogs/locations/1/edit
  def edit
    @eureka = 'notnil'
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /catalogs/locations
  # POST /catalogs/locations.json
  def create
    @catalogs_location = Catalogs::Location.new(catalogs_location_params)

    respond_to do |format|
      if @catalogs_location.save
        format.html { redirect_to @catalogs_location, notice: t('.created') }
        format.json { render :show, status: :created, location: @catalogs_location }
        format.js   { redirect_to @catalogs_location, notice: t('.created') }
      else
        format.html { render :new }
        format.json { render json: @catalogs_location.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /catalogs/locations/1
  # PATCH/PUT /catalogs/locations/1.json
  def update
    respond_to do |format|
      if @catalogs_location.update(catalogs_location_params)
        format.html { redirect_to @catalogs_location, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @catalogs_location }
      else
        format.html { render :edit }
        format.json { render json: @catalogs_location.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /catalogs/locations/1
  # DELETE /catalogs/locations/1.json
  def destroy
    @catalogs_location.destroy
    respond_to do |format|
      format.html { redirect_to catalogs_locations_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_location
      @catalogs_location = Catalogs::Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogs_location_params
      params.require(:catalogs_location).permit(:department, :responsible, :email)
    end
end
