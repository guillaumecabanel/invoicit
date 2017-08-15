class BankAccountStatementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    user.bank_account_statement.nil?
  end

  def update?
    record.user == user
  end
end
