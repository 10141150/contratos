class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
  def send_mail(email, system_contract, notification_type, start_date, end_date)
      @email=email
      @system_contract = system_contract
      @start_date = start_date
      @end_date = end_date
    
	  	file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
		  @mail_secretary = file_yaml["production"]['e_mail_technical_secretary']
      @notification_type = notification_type
    
	  	email.insert(0,@mail_secretary+",")
	  	puts "eeeeeemaaaaaaaillllll!!!!!!!!"
	  	puts email
      
      puts 'description contrato!!!!!!'
      puts @system_contract.description
      puts 'description contrato!!!!!!'
    

		#@user = user
		#@url  = 'http://codeHero.co'
		#email.each do |correo|
    case notification_type
      when "create_contract"
      
      @header = "Este es un correo de notificación del contrato " + @system_contract.contract_no.to_s + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description.to_s + "con fecha de inicio " + @start_date.to_s + " y con fecha final " + @end_date.to_s
      mail(to: @email, subject: 'Creacion de contracto con el INB')
    when "update_contract"
      @header = "Este es un correo de notificación del contrato " + @system_contract.contract_no + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description
      mail(to: @email, subject: 'Actualizacion de contracto con el INB')
    when "create_renewal"
      @header = "Este es un correo de renovacion del contrato " + @system_contract.contract_no + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description + "con fecha de inicio " + @start_date.to_s + " y fecha de finalización de " + @end_date.to_s
      mail(to: @email, subject: 'Creacion de renovacion con el INB')
    when "update_renewal"
      @header = "Este es un correo de renovacion del contrato " + @system_contract.contract_no + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description + "con fecha de inicio " + @start_date.to_s + " y fecha de finalizacion de " + @end_date.to_s
      mail(to: @email, subject: 'Actualizacion de renovacion con el INB')
    when "create_siteview"
      @header = "Este es un correo de notificación de visita por el contrato " + @system_contract.contract_no + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description + "Fecha de visita: " + @start_date.to_s 
      mail(to: @email, subject: 'Creacion de visita con el INB')
    when "update_siteview"
      @header = "Este es un correo de actualizacion de visita por el contrato " + @system_contract.contract_no + " con el INB de la UNAM" 
      @contenido = "La descripción del contrato es la siguiente " + @system_contract.description + "Fecha de visita:" + @start_date.to_s
	    mail(to: @email, subject: 'Actualizacion de visita con el INB')
    end 
	end

end
