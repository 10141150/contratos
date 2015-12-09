require 'net/ftp'
class System::FilesController < ApplicationController
  Ruta_archivo_comentarios = "public/comments/comentarios.txt";
  Ruta_directorio_archivos = "public/files/";  
  
  @aux = nil
   
  def load_files
  @renewal_id=params[:renewal_id];
    renewal = System::Renewal.find(@renewal_id)
  @contract_no = renewal.contract.contract_no
    
  @formato_erroneo = false;
   if request.post?
      #Archivo subido por el usuario.
      archivo = params[:files][:file];
      #Nombre original del archivo.
      nombre = @renewal_id.to_s + "_" + archivo.original_filename;
      #Directorio donde se va a guardar.
      directorio = Ruta_directorio_archivos;
      #Extensión del archivo.
	  puts 'aki va el nombre Renewallllllllllllllllllllllllllllllllllllll'
	  puts @renewal_id
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
      #Verifica que el archivo tenga una extensión correcta.
      if extension == ".pdf" or extension == ".doc" or extension == ".docx"
         #Ruta del archivo.
         path = File.join(directorio, @contract_no + "_" + @renewal_id + extension);
         #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
         resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
		 
  
         #Verifica si el archivo se subió correctamente.
		 ftp = Net::FTP.new('ftp.Smarterasp.net', 'mcpramirez-001', 'windowslnx')
		 ftp.chdir('/site1/')
         ftp.storbinary("STOR " + archivo.original_filename, StringIO.new(archivo.read), Net::FTP::DEFAULT_BLOCKSIZE)
		 ftp.close
         if resultado
            subir_archivo = "ok";
            redirect_to :controller => "contracts", :action => "index"
         else
            subir_archivo = "error";
            #Redirige al controlador "archivos", a la acción "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subió el archivo y "error" si no se pudo.
            redirect_to :controller => "files", :action => "list_files", :subir_archivo => subir_archivo;
         end
         #Redirige al controlador "archivos", a la acción "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subió el archivo y "error" si no se pudo.
         #redirect_to :controller => "files", :action => "list_files", :subir_archivo => subir_archivo;
      else
         @formato_erroneo = true;
      end
    end
	
  end

  def list_files
   #Guardamos la lista de archivos de la carpeta "archivos".
   @archivos = Dir.entries(Ruta_directorio_archivos);
   #Mensaje que mostrará si la página viene desde otra acción.
   @mensaje = "";
   #Verificamos si existe la variable subir_archivo por GET.
   if params[:subir_archivo].present?
      if params[:subir_archivo] == "ok";
         @mensaje = t('.upload_file_ok') ;
      else
         @mensaje = t('.upload_file_fail') ;
      end
   end
   #Verificamos si existe la variable eliminar_archivo por GET.
   if params[:eliminar_archivo].present?
      if params[:eliminar_archivo] == "ok";
         @mensaje = t('.deleted_file');
      else
         @mensaje = t('.not_deleted_file');
      end
   end
   #Verifica si existe el archivo de los comentarios.
   if File.exist?(Ruta_archivo_comentarios)
      @comentarios = File.read(Ruta_archivo_comentarios);
   else
      @comentarios = "";
   end
   
  end

  def delete_files
  
   #Recuperamos el nombre del archivo.
   archivo_a_borrar = params[:archivo_a_borrar];
   #Guardamos la ruta del archivo a eliminar.
   ruta_al_archivo = Ruta_directorio_archivos + archivo_a_borrar;
   #Verificamos que el archivo exista para eliminarlo.
   if File.exist?(ruta_al_archivo)
      #Si el archivo existe se intentará eliminarlo. Dentro de la variable resultado se guardará true si se pudo eliminar y false si no.
      resultado = File.delete(ruta_al_archivo);
   else
      #El archivo no existe así que no se pudo eliminar nada.
      resultado = false;
   end
   #Verifica si el archivo se eliminó correctamente.
   if resultado
      eliminar_archivo = "ok";
   else
      eliminar_archivo = "error";
   end
   redirect_to :controller => "files", :action => "list_files", :eliminar_archivo => eliminar_archivo;
   
   
  end

  def save_comments
  
  #Si llega por post intentará guardar los comentarios que ha ingresado el usuario.
   if request.post?
      #Guarda los comentarios en una variable
      comentarios = params[:files][:comentarios];
      #Abre el archivo de comentarios, Si no existe lo crea, si existe lo sobrescribe
      File.open(Ruta_archivo_comentarios, "wb"){
         #Alias
         |f|;
         #Escribe el contenido del archivo.
         f.write(comentarios);
         #Lo cierra para liberar memoria.
         f.close();
      };
   end
   #Verifica si existe el archivo de los comentarios.
   if File.exist?(Ruta_archivo_comentarios)
      #Guarda el contenido del archivo de los comentarios.
      @comentarios = File.read(Ruta_archivo_comentarios);
   else
      #No existe el archivo de los comentarios así que guarda comillas vacías en los comentarios.
      @comentarios = "";
   end
  end

end
