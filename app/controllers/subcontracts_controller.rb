class SubcontractsController < ApplicationController
  before_action :set_partner, only: [:new, :create]

  def new
    @subcontract = Subcontract.new
    @invoices = policy_scope(Invoice)
    authorize @subcontract
    authorize @invoices
  end

  def create
    @invoices = policy_scope(Invoice)
    authorize @invoices

    @subcontract = Subcontract.new(subcontract_params)
    @subcontract.partner = @partner
    authorize @subcontract

    if @subcontract.save
      redirect_to partner_path(@partner)
    else
      binding.pry
      render :new
    end
  end

  private

  def subcontract_params
    params.require(:subcontract).permit(
      :amount,
      :invoice_id
    )
  end

  def set_partner
    @partner = Partner.find(params[:partner_id])
    authorize @partner
  end
end
