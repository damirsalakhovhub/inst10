class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show ]

  # Example of using Pagy for pagination
  def index
    authorize User
    @pagy, @users = pagy(policy_scope(User).order(created_at: :desc))
  end

  # Example of fragment caching
  def show
    authorize @user
    # View will use fragment caching for user profile
  end

  # Example of N+1 prevention with eager loading
  def dashboard
    # This would be defined in a real app
    # @posts = current_user.posts.includes(:comments, :author)
  end

  private

  def set_user
    # Prevent conflicts with Devise routes (sign_out, sign_in, etc.)
    raise ActiveRecord::RecordNotFound if params[:id].match?(/\A(sign_out|sign_in|sign_up|password|cancel|edit)\z/)
    @user = User.find(params[:id])
  end
end
