require 'axlsx'
class System::ReporterController < ApplicationController
  $pdf_var = System::Renewal.all

    $filtro_fecha_inicio = nil
    $filtro_fecha_fin = nil   

  def index
    @aux = nil
  	@system_contract=System::Contract.all
  	@catalog_supplier = Catalogs::Supplier.all
    @catalog_device = Catalogs::Device.all
	  @renewals=System::Renewal.all    
    @catalog_renewals = @renewals
	  @system_renewals = Array.new()

  	respond_to do |format|
      format.html do
			 if params[:start_date].nil? or params[:end_date].nil?
        puts "fechaaaaaaaaaaaaaaaaaaa!!!!!!#{params[:end_date].class}"
        filter_without_date
			 else
        filter_with_date
		   end
      end
      format.xlsx do
        puts "variablepdfffffffffffffff!!!!#{$pdf_var.nil?}"
        Axlsx::Package.new do |p|
            p.workbook.add_worksheet(:name => "Prueba 1") do |sheet|
              sheet.add_row ["Nombre de Equipo", "Proveedor", "No. Contrato", "Monto", "Fecha inicial" , "Fecha final"]
              $pdf_var.each do |sc|
                sheet.add_row [sc.contract.device.name, sc.contract.supplier.business_name, sc.contract.contract_no, sc.monto, sc.start_date, sc.end_date]
              end
            end
            #p.serialize('simple.xlsx')
            send_data p.to_stream.read, :filename => "Prueba 1.xlsx"
          end
      end
     format.js do
        #@system_renewals.insert(0,System::Renewal.first)
        #@system_renewals.insert(0,System::Renewal.last)
        #@system_renewals = System::Renewal.first
        if params[:start_date].nil? or params[:end_date].nil?
          puts "fechaaaaaaaaaaaaaaaaaaa!!!!!!#{params[:end_date].class}"
          filter_without_date
        else
          filter_with_date
        end
        render :body
      end
     format.pdf do
        puts "variablepdfffffffffffffff!!!!#{$pdf_var.class}"
        pdf = ReportPDF.new($pdf_var, $filtro_fecha_inicio, $filtro_fecha_fin)
        send_data pdf.render, filename: "PDF Test.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def update_contracts
    if params[:device].nil?
      contract = Catalogs::Supplier.find(params[:supplier].to_i)
    else
      contract = Catalogs::Device.find(params[:device].to_i)
    end
    #@system_contract = contract.Contracts
  end

  def update_renewals
    puts "PAraaaaaammmmsssss!!!!!!!!!!!!!!!!!!!#{params[:contract_param_no].to_i}"
    renew = System::Contract.find(params[:contract_param_no].to_i)
    #puts "Deviceeeeeeeees!!!!#{contract.class}"
    #@catalog_device = System::Device.all.map{|e| [e.name, e.id]}.insert(0, "Seleccione equipo...")
    #@catalog_device = contract.device.map{|e| [e.name, e.id]}.insert(0, "Seleccione equipo...")
    #@catalog_device = contract.device
    @catalog_renewals = renew.Renewals
  end

  def clean_device_contract
    @catalog_device = Catalogs::Device.all
    @system_contract=System::Contract.all
  end

  def clean_device_supplier
    @catalog_device = Catalogs::Device.all
    @catalog_supplier = Catalogs::Supplier.all
  end

  def clean_supplier_contract
    @catalog_supplier = Catalogs::Supplier.all
    @system_contract=System::Contract.all
  end

  def use_filter_date
    puts "feeeeeeeeeeeeeechaaaaaaaaaaaaaaaaaaaaaa!#{params[:use_date]}"
    @catalog_supplier = Catalogs::Supplier.all
    if params[:use_date].to_i == 1
      @use_date = false
    else
      @use_date = false
    end
  end

  def filter_without_date
    $filtro_fecha_inicio = nil
    $filtro_fecha_fin = nil
    if params[:contract_param_no].nil? or params[:contract_param_no].to_i == 0
      if params[:device].nil? or params[:device].to_i == 0
        if params[:supplier].nil? or params[:supplier].to_i ==0 
          @system_renewals = @renewals
          $pdf_var = @system_renewals
          puts "variableeeeeeeeeeee!!!!!!!!!#{$pdf_var.first}"
        else
          select_supplier
        end
      else
        select_device
      end
    else
      select_contract
    end
  end

  def filter_with_date
     puts "fechaaaaaaaa! :o"
      format1=*params["start_date"].values.map(&:to_i)
      t0=Date.new(format1[2],format1[1],format1[0])
            format2=*params["end_date"].values.map(&:to_i)
      t1=Date.new(format2[2],format2[1],format2[0])
        $filtro_fecha_inicio = t0.to_formatted_s(:iso8601)
        $filtro_fecha_fin = t1.to_formatted_s(:iso8601)
      puts "variable renewals!!!!!!!!!!!!!!!!!!!!#{@renewals}"
      unless params[:supplier].nil? or params[:supplier].to_i == 0
        puts "si pasoooooooooooooooooo!?!?!?!?!?!?!?!?!?!?!"
        select_supplier
        @renewals = @system_renewals
        @system_renewals = Array.new()
      end
       unless params[:device].nil? or params[:device].to_i == 0
        puts "si pasoooooooooooooooooo!?!?!?!?!?!?!?!?!?!?!"
        select_device
        @renewals = @system_renewals
        @system_renewals = Array.new()
      end
      unless params[:contract_param_no].nil? or params[:contract_param_no].to_i == 0
        puts "si pasoooooooooooooooooo!?!?!?!?!?!?!?!?!?!?!"
        select_contract
        @renewals = @system_renewals
        @system_renewals = Array.new()
      end
      @renewals.each do |renewal|
        if (renewal.date_filter(t0,t1) == :active)
          #me parece que aqui ya se filtro por activos o inactivos
          @system_renewals.insert(0,renewal)
        else

        end
        $pdf_var = @system_renewals
        puts "funcionaaaaaaaaaaaaaa!!!!!#{$pdf_var}"
      end
  end

  def select_contract
    puts "What!!!!!!??????????????????????????? #{params[:contract_param_no].class}"
    cntrct = System::Contract.find(params[:contract_param_no].to_i)
      rnwls = cntrct.Renewals
      rnwls.each do |rnwl|
        if params[:active].to_i == 1
          if rnwl.stat == :active
            @system_renewals.insert(0,rnwl)
          end
        else
          @system_renewals.insert(0,rnwl)
        end
      end
    $pdf_var = @system_renewals
  end

  def select_supplier
      puts "Supplieeeeer! #{params[:supplier].to_i}"
      contracts = System::Contract.where("supplier_id = '#{params[:supplier].to_i}'")
      contracts.each do |cntrct|
        rnwls = System::Renewal.where("contract_id = '#{cntrct.id.to_i}'")
        rnwls.each do |rnwl|
          if params[:active].to_i == 1
            if rnwl.stat == :active
              @system_renewals.insert(0,rnwl)
            end
          else
            @system_renewals.insert(0,rnwl)
          end
        end
      end 
      $pdf_var = @system_renewals
     
  end

  def select_device
    puts "Deviceeeeeeeees!!!!#{params[:device]}"
    contracts = System::Contract.where("device_id = '#{params[:device].to_i}'")
    contracts.each do |cntrct|
      rnwls = System::Renewal.where("contract_id = '#{cntrct.id.to_i}'")
      rnwls.each do |rnwl|
        @system_renewals.insert(0,rnwl)
      end
    end
    $pdf_var = @system_renewals
  end  

end
