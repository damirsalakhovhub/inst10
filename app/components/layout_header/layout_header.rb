# Layout Header Component
# Global application header with user info and sign out link
# See layout_header.html.erb for template and layout_header.scss for styles

class LayoutHeader::LayoutHeader < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  private

  attr_reader :user

  def signed_in?
    user.present?
  end
end

