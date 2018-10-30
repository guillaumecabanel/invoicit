class DashboardsController < ApplicationController
  def show
    set_user
    user_invoices = policy_scope(Invoice)
    @sent_invoices = user_invoices.where.not(sent_at: nil).order(:sent_at)
    @sent_subcontracts = Subcontract.where(invoice: @sent_invoices)
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end
