# encoding: UTF-8
class System::ConfigurationController < ApplicationController

  @aux = nil

  def configure
  	@configuration_fields = YAML.load_file "#{Rails.root}/config/config.yml"
  	@mailers = @configuration_fields["production"]

    @traduccion_fields = YAML.load_file "#{Rails.root}/config/locales/es.yml"
    @traduccion = @traduccion_fields["es"]["configure"]
  	#@configuration_fields = "#{APP_CONFIG[:technical_secretary][:e_mail]}"
  end

  def edit
  	puts "XXXXXXXXXXXXXXXX#{@mailers.class}"
  	#@edit_mailers = @mailers
  	@edit_name = params[:name_param]
  	@edit_email = params[:mail_param]
  end

  def save
    @file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
    #La linea de abajo sirve para depurar la cadena en caso de que marque algun error de codificación
    #Al parecer no acepta acentos.
    prueba = @file_yaml["production"]
    prueba.each do | key, value |
      @file_yaml["production"][key] = params[:configure][key].encode("UTF-8", "binary", :invalid => :replace, :undef => :replace, :replace => "?")
    end
    @file_yaml.to_yaml
    #puts "Prueba para el Save #{@file_yaml}"
    resultado = File.open("#{Rails.root}/config/config.yml", 'w+') { |f| YAML.dump(@file_yaml, f)}
    
    if resultado
      puts 'Nos vamos a contratos'
      redirect_to :controller => "contracts", :action => "index"
    else
      redirect_to :controller => "configuration", :action => "configure"
    end    
  end
end
