class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: @user.id)
    end
  end

  def update?
    @user == user
  end
end
