class SubcontractsController < ApplicationController
  before_action :set_partner,     only: [:new, :create, :edit, :update]
  before_action :set_invoices,    only: [:new, :create, :edit, :update]
  before_action :set_subcontract, only: [:edit, :update]

  def new
    @subcontract = Subcontract.new
    authorize @subcontract
  end

  def create
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

  def edit
  end

  def update
    if @subcontract.update(subcontract_params)
      redirect_to partner_path(@partner)
    else
      render :edit
    end
  end

  private

  def subcontract_params
    params.require(:subcontract).permit(
      :amount,
      :invoice_id
    )
  end

  def set_subcontract
    @subcontract = Subcontract.find(params[:id])
    authorize @subcontract
  end

  def set_partner
    @partner = Partner.find(params[:partner_id])
    authorize @partner
  end

  def set_invoices
    @invoices = policy_scope(Invoice)
    authorize @invoices
  end
end
