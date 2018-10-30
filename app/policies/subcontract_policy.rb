class SubcontractPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def update?
    record.partner.user == user
  end

  def destroy?
    record.partner.user == user
  end
end
