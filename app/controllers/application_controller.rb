class ApplicationController < ActionController::Base
    
    def access_denied(exception)
        redirect_to admin_admin_users_path, alert: exception.message
      end
end
