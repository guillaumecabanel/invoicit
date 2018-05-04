class CompaniesController < ApplicationController
  before_action :bank_account_statement_exist
  before_action :set_company, only: [:show, :edit, :update]

  def index
    @companies = policy_scope(Company)
  end

  def show
    @invoices_sent = @company.invoices.where.not(sent_at: nil).order(sent_at: :desc)
    @invoices_to_send = @company.invoices.where(sent_at: nil).order(:created_at)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new company_params
    @company.user = current_user
    authorize @company
    if @company.save
      redirect_to company_path @company
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to company_path @company
    else
      render :edit
    end
  end

  private

  def bank_account_statement_exist
    if current_user.bank_account_statement.nil?
      redirect_to new_bank_account_statement_path
    end
  end

  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

  def company_params
    params.require(:company).permit(:title,
                                    :address_street,
                                    :address_postal_code,
                                    :address_city,
                                    :contact_first_name,
                                    :contact_last_name,
                                    :contact_email,
                                    :contact_phone_number
                                  )
  end
end
