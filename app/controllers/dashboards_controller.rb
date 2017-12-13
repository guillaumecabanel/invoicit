class DashboardsController < ApplicationController
  def show
    set_user
    user_invoices = policy_scope(Invoice)
    @sent_invoices_by_year = user_invoices.where.not(sent_at: nil).group_by{ |invoice| invoice.updated_at.year }
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end
