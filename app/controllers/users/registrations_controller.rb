class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      # Registration failed - redirect to landing with errors
      clean_up_passwords resource
      set_minimum_password_length
      # Store errors and params in session to restore on landing page
      session[:registration_errors] = resource.errors.to_hash
      session[:registration_params] = sign_up_params.except(:password, :password_confirmation)
      redirect_to root_path
    end
  end

  protected

  # Override to redirect to home after successful signup
  def after_sign_up_path_for(resource)
    home_path
  end
end

