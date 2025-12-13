class ProjectPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    owner_or_admin?
  end

  def create?
    user.present?
  end

  def update?
    owner_or_admin?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user
      return scope.all if user.admin?

      scope.where(user_id: user.id)
    end
  end

  private

  def owner_or_admin?
    user.present? && (user.admin? || record.user_id == user.id)
  end
end

