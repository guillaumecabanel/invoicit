class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def update?
    record.invoice.company.user == user
  end

  def destroy?
    record.invoice.company.user == user
  end
end
