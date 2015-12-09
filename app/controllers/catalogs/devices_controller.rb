class Catalogs::DevicesController < ApplicationController
  before_action :set_catalogs_device, only: [:show, :edit, :update, :destroy]

  # GET /catalogs/devices
  # GET /catalogs/devices.json
  def index
    @aux = 'notnil'
  	if admin_signed_in?
    	puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    	if params[:codigo].nil? || params[:codigo].empty?
    		@catalogs_devices = Catalogs::Device.all.paginate(page: params[:page], per_page: 10)
  		else
   		 #@catalogs_suppliers.where(business_name: params[:codido])     		 @catalogs_devices= Catalogs::Device.where("name LIKE :codigo or unam_stock_number LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 10)
    	end
	  else
	    redirect_to new_admin_session_path
	  end
  end

  # GET /catalogs/devices/1
  # GET /catalogs/devices/1.json
  def show
  end

  # GET /catalogs/devices/new
  def new
    @catalogs_device = Catalogs::Device.new
    @eureka = nil
  end

  # GET /catalogs/devices/1/edit
  def edit
    @eureka = 'notnil'
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /catalogs/devices
  # POST /catalogs/devices.json
  def create
    @catalogs_device = Catalogs::Device.new(catalogs_device_params)

    respond_to do |format|
      if @catalogs_device.save
        format.html { redirect_to @catalogs_device, notice: t('.created') }
        format.json { render :show, status: :created, location: @catalogs_device }
        format.js   { redirect_to @catalogs_device, notice: t('.created') }
      else
        format.html { render :new }
        format.json { render json: @catalogs_device.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /catalogs/devices/1
  # PATCH/PUT /catalogs/devices/1.json
  def update
    respond_to do |format|
      if @catalogs_device.update(catalogs_device_params)
        format.html { redirect_to @catalogs_device, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @catalogs_device }
      else
        format.html { render :edit }
        format.json { render json: @catalogs_device.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /catalogs/devices/1
  # DELETE /catalogs/devices/1.json
  def destroy
    @catalogs_device.destroy
    respond_to do |format|
      format.html { redirect_to catalogs_devices_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogs_device
      @catalogs_device = Catalogs::Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogs_device_params
      params.require(:catalogs_device).permit(:name, :unam_stock_number, :location_id)
    end
end
