class LandingController < ApplicationController
  def index
    # Redirect authenticated users to home
    redirect_to home_path if user_signed_in?
    
    # Use resource from params if present (from failed registration)
    @resource = params[:user] ? User.new(user_params) : User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
    
    # Restore errors from flash if present
    if flash[:alert]
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

