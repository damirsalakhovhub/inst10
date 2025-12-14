class LandingController < ApplicationController
  def index
    # Redirect authenticated users to home
    redirect_to home_path if user_signed_in?
    
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping
end

