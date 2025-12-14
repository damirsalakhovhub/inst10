class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      # If sign in failed, redirect to landing page with error message
      unless resource.persisted?
        set_flash_message!(:alert, :invalid)
        redirect_to root_path and return
      end
    end
  end

  protected

  # Redirect to landing page on failed sign in (instead of /users/sign_in)
  def after_sign_in_failure_path_for(resource_name)
    root_path
  end

  # Override respond_with to force redirect on failure
  def respond_with(resource, _opts = {})
    if resource.persisted?
      super
    else
      set_flash_message!(:alert, :invalid)
      redirect_to root_path
    end
  end
end

