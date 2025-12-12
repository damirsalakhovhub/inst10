class UserPolicy < ApplicationPolicy
  # Example policy for User model
  # Shows how to implement authorization rules

  def index?
    # Only admins can see list of all users
    user&.admin?
  end

  def show?
    # Users can see their own profile, admins can see anyone
    user&.admin? || record == user
  end

  def create?
    # Only admins can create new users
    user&.admin?
  end

  def update?
    # Users can update their own profile, admins can update anyone
    user&.admin? || record == user
  end

  def destroy?
    # Only admins can delete users
    # But admins cannot delete themselves
    user&.admin? && record != user
  end

  # Scope for limiting which users can be seen
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.admin?
        # Admins can see all users
        scope.all
      else
        # Regular users can only see themselves
        scope.where(id: user&.id)
      end
    end
  end
end
