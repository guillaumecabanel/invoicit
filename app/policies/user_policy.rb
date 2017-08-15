class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(@user = user)
    end
  end

  def update?
    @user == user
  end
end
