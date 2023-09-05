class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:bio])
        devise_parameter_sanitizer.permit(:account_update, keys: [:profile_img])
        # Add other permitted parameters if needed
    end

    

    private
  
    def set_notifications
      notifications = Notification.where(recipient: current_user).newest_first.limit(9)
      @unread = notifications.unread
      @read = notifications.read
    end
end
