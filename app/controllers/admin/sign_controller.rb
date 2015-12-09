class Admin::SignController < ApplicationController
 def index
	if admin_signed_in?
		@currentuser = current_admin.login
		redirect_to system_contracts_path
		else 
		redirect_to new_admin_session_path
	end
  end
end
