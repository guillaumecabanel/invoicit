class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update]

  def index
    @partners = policy_scope(Partner)
  end

  def show
  end

  def new
    @partner = Partner.new
    authorize @partner
  end

  def create
    @partner = Partner.new(partner_params)
    @partner.user = current_user
    authorize @partner

    if @partner.save
      redirect_to partner_path(@partner)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @partner.update(partner_params)
      redirect_to partner_path(@partner)
    else
      render :edit
    end
  end

  private

  def partner_params
    params.require(:partner).permit(
      :first_name,
      :last_name
    )
  end

  def set_partner
    @partner = Partner.find(params[:id])
    authorize @partner
  end
end
