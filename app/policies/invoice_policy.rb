class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(company: Company.where(user: user))
    end
  end

  def create?
    true
  end

  def show?
    record.company.user == user
  end

  def update?
    true
  end

  def send_via_email?
    record.company.user == user
  end

  def mark_as_paid?
    send_via_email?
  end
end
