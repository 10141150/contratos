module Delayed_Calendar
    extend ActiveSupport::Concern

    module ClassMethods

			
      def delayed_event_update(time_min_param,delayed_id_param)
        begin
        job=Delayed::Job.find(delayed_id_param)
        job.update_attributes(run_at: time_min_param)
      rescue 'ActiveRecord::RecordNotFound'  
      return 
        end
        
      end
	
      def delayed_event_delete(delayed_id_param)
        begin
        job=Delayed::Job.find(delayed_id_param)
        job.destroy
      rescue
        end
	    end

      def delayed_event_delete_cascade_contract(contract_id)  
		begin
			contrato=System::Contract.find(contract_id)
      @renovaciones=contrato.Renewals
					@renovaciones.each do |r|
            System::Contract.delayed_event_delete(r.delayed_id_start)
            System::Contract.delayed_event_delete(r.delayed_id_end)
						begin 
							@visitas=r.Siteviews
							@visitas.each do |v|
                System::Contract.delayed_event_delete(v.delayed_id_start)
							end
						rescue
						end
					end
		rescue
      puts 'Se han procesado las eliminaciones del calendario de Delayed en cascada'
	end
  end
    
      def delayed_event_delete_cascade_renewal(renewal_id)
      renewal=System::Renewal.find(renewal_id)
        System::Renewal.delayed_event_delete(renewal.delayed_id_start)
        System::Renewal.delayed_event_delete(renewal.delayed_id_end)
        			begin 
              @visitas=renewal.Siteviews
							@visitas.each do |v|
                System::Renewal.delayed_event_delete(v.delayed_id_start)
							end
						rescue
  end   
  end
      
end
end