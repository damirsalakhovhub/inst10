class LandingController < ApplicationController
  def index
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping
end

