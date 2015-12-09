class System::SiteviewsController < ApplicationController
  before_action :set_system_siteview, only: [:show, :edit, :update, :destroy]

  # GET /system/siteviews
  # GET /system/siteviews.json
 def index
  @aux = 'notnil'
 if admin_signed_in?

   
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#{params[:codigo]}"
    if params[:codigo].nil? || params[:codigo].empty?
      @system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 10)
    else
      #@system_siteviews = System::Siteview.all.paginate(page: params[:page], per_page: 10)

      @catalogs_siteviews = Catalogs::Siteview.where("visit_date LIKE :codigo",{:codigo => "%#{params[:codigo]}%"}).paginate(page: params[:page], per_page: 2)
    end
	else
	   redirect_to new_admin_session_path
  end
  end

  # GET /system/siteviews/1
  # GET /system/siteviews/1.json
  def show

  end

  # GET /system/siteviews/new
  def new
	@renewal_id = params[:renewal_id]
  @renewal = System::Renewal.find(params[:renewal_id])
    puts "Renewaaaaaaaaaaaaaaaaaaaaaaaaaal!!!!!!!!!!#{params[:renewal_id]}"
    @page = params[:page]
    @system_siteview = System::Siteview.new
    @eureka = nil
  end

  # GET /system/siteviews/1/edit
  def edit
    @eureka = 'notnil'
	@renewal = params["id"]
  end

  def delete
   @id=params[:id]
   @viewer=params[:viewer]
  end

  # POST /system/siteviews
  # POST /system/siteviews.json
  def create
		
		@start_date=Time.new(system_siteview_params["visit_date(1i)"].to_i,system_siteview_params["visit_date(2i)"].to_i,system_siteview_params["visit_date(3i)"].to_i,system_siteview_params["visit_date(4i)"],system_siteview_params["visit_date(5i)"].to_i)
        
		format2=*params["recordar"].values.map(&:to_i)
	    @end_date=Date.new(format2[2],format2[1],format2[0])

		@start_date_google=system_siteview_params["visit_date(1i)"].to_s + '-' + system_siteview_params["visit_date(2i)"].to_s + '-' + system_siteview_params["visit_date(3i)"].to_s + 'T'+system_siteview_params["visit_date(4i)"].to_s+':'+system_siteview_params["visit_date(5i)"].to_s+':00-06:00'
		puts 'AKI VA LA HOR ADE GOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOGLE'
		puts @start_date_google
	    @system_siteview = System::Siteview.new(system_siteview_params)
            renewal=System::Renewal.find(system_siteview_params[:renewal_id])
            format=*params["recordar"].values.map(&:to_i)
   
    
    @recordar=Time.new(format[2],format[1],format[0],format[3],format[4]) 
            @email=renewal.contract.supplier.email
            puts 'AKI DEBE IR EL PARAMETRO RECORDAR ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts @recordar
            puts 'AKI VA EL CAMPO NOW TIME ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts Time.now
            puts 'AKI TERMINA IR EL PARAMETRO EMAIL ROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOT'
            puts @email
            array_mailer = [@email, params[:notificaciones]]
            puts array_mailer
			@x=System::Renewal.find(system_siteview_params[:renewal_id])
			@google_event_start = System::Siteview.event_insert(@start_date_google,@start_date_google,@x.contract.description,'neuro')
      @delayed_id_start = ApplicationMailer.delay(run_at: @recordar).send_mail(array_mailer,@x.contract,'create_siteview', @start_date, nil)
    
    puts 'AKI DEBE SALIR EL ID DEL EVENETO DELAYED_JOBS'
    puts @delayed_id_start.id
     puts 'AKI DEBE SALIR EL ID DEL EVENETO DELAYED_JOBS'
    
			@system_siteview= System::Siteview.new(renewal_id: system_siteview_params[:renewal_id], visit_date: @start_date, google_event_start: @google_event_start, completed: system_siteview_params[:completed], delayed_id_start: @delayed_id_start.id)

    respond_to do |format|
    if @system_siteview.save
	
        format.html { redirect_to @system_siteview, notice: t('.created') }
        format.json { render :show, status: :created, location: @system_siteview }
        format.js   { redirect_to @system_siteview, notice: t('.created') }
      else
        format.html { render :new }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  # PATCH/PUT /system/siteviews/1
  # PATCH/PUT /system/siteviews/1.json
  def update
 	    @start_date=Time.new(system_siteview_params["visit_date(1i)"].to_i,system_siteview_params["visit_date(2i)"].to_i,system_siteview_params["visit_date(3i)"].to_i,system_siteview_params["visit_date(4i)"].to_i,system_siteview_params["visit_date(5i)"].to_i)
		
		format2=*params["recordar"].values.map(&:to_i)
    @end_date=Time.new(format2[2],format2[1],format2[0],format2[3],format2[4],format2[5])

		@start_date_google=system_siteview_params["visit_date(1i)"].to_s + '-' + system_siteview_params["visit_date(2i)"].to_s + '-' + system_siteview_params["visit_date(3i)"].to_s + 'T'+system_siteview_params["visit_date(4i)"].to_s+':'+system_siteview_params["visit_date(5i)"].to_s+':00-06:00'

		x=System::Renewal.find(system_siteview_params[:renewal_id])
		@google_event_start=System::Siteview.find(params[:id]).google_event_start
		
    visita = System::Siteview.find(params[:id])
    
    @email = visita.renewal.contract.supplier.email
    @system_contract = visita.renewal.contract
    
  
    
    System::Renewal.delayed_event_delete(System::Siteview.find(params[:id]).delayed_id_start)
    @delayed_id_start = ApplicationMailer.delay(run_at: @end_date).send_mail(@email, @system_contract,'update_siteview', @start_date, nil)

 
    
		System::Siteview.event_update(@start_date_google,@start_date_google,x.contract.description,'neuro',@google_event_start)
		puts 'Aki va la hora del star_dateeeeeeeeeeeeeeeeeeeeeeeeeeee'
		puts @start_date
		puts 'Aki termina la hora del star_dateeeeeeeeeeeeeeeeeeeeeeee'
    respond_to do |format|
      visita = System::Siteview.find(params[:id])
    
      
      if @system_siteview.update(renewal_id: system_siteview_params[:renewal_id], visit_date: @start_date, google_event_start: @google_event_start, completed: system_siteview_params[:completed], delayed_id_start: @delayed_id_start.id)
        format.html { redirect_to @system_siteview, notice: t('.updated') }
        format.json { render :show, status: :ok, location: @system_siteview }
      else
        format.html { render :edit }
        format.json { render json: @system_siteview.errors, status: :unprocessable_entity }
        format.js   { render :edit }
      end
    end
  end

  # DELETE /system/siteviews/1
  # DELETE /system/siteviews/1.json
  def destroy
    begin
    Delayed::Job.find(@system_siteview.delayed_id_start).destroy
    rescue 
    end
    
  puts 'destruyendo eventooooooooooooooooooooooooooo'
    System::Siteview.event_delete(System::Siteview.find(params[:id]).google_event_start)
    @system_siteview.destroy
    respond_to do |format|
      format.html { redirect_to system_siteviews_url, notice: t('.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_siteview
      @system_siteview = System::Siteview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_siteview_params
      params.require(:system_siteview).permit(:renewal_id, :visit_date, :completed, :delayed_id_start)
    end
end
