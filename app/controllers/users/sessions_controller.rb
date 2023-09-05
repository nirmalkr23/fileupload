# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # Your authentication logic here

    if user_authenticated_successfully
      sign_in(user) # Assuming you are using Devise or similar authentication gem
      user.update(online_status: true) # Set the user's status to "online"
      redirect_to root_path
    else
      flash[:alert] = 'Invalid login credentials'
      render :new
    end
  end

  def destroy
    # Your logout logic here
    user.update(online_status: false) # Set the user's status to "offline" when they log out
    sign_out(user) # Assuming you are using Devise or similar authentication gem
    redirect_to root_path
  end
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
