class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  before_action :set_current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    Current.user = current_user if user_signed_in?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  # Override Devise's after_sign_in_path_for to redirect to home
  def after_sign_in_path_for(resource)
    home_path
  end
end
