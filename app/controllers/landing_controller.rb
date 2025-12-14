class LandingController < ApplicationController
  def index
    # Redirect authenticated users to home
    redirect_to home_path if user_signed_in?
    
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
    
    # Restore registration errors from session if present
    if session[:registration_errors]
      session[:registration_errors].each do |field, messages|
        Array(messages).each { |msg| @resource.errors.add(field, msg) }
      end
      # Restore email if present
      @resource.email = session[:registration_params][:email] if session[:registration_params]&.dig(:email)
      # Clear session
      session.delete(:registration_errors)
      session.delete(:registration_params)
    end
    
    # Restore errors from flash if present (for login)
    if flash[:alert] && @resource.errors.empty?
      @resource.errors.add(:base, flash[:alert])
    end
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

