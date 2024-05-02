class MoviePolicy < ApplicationPolicy
  
  def index?
    true
  end

  def show?
    record.user.blank? || record.user == user
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      user.present? ? scope.owned(user).or(scope.shared) : scope.none
    end
  end
end
