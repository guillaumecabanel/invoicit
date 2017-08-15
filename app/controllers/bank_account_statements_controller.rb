class BankAccountStatementsController < ApplicationController
  before_action :bank_account_statement_params, only: [:create, :update]

  def new
    @bank_account_statement = BankAccountStatement.new
    authorize @bank_account_statement
  end

  def create
    @bank_account_statement = BankAccountStatement.new(bank_account_statement_params)
    authorize @bank_account_statement
    @bank_account_statement.user = current_user

    if @bank_account_statement.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bank_account_statement = current_user.bank_account_statement
    authorize @bank_account_statement
  end

  def update
    @bank_account_statement = current_user.bank_account_statement
    if @bank_account_statement.update(bank_account_statement_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def bank_account_statement_params
    params.require(:bank_account_statement).permit(
      :bank_code,
      :counter_number,
      :account_number,
      :key,
      :currency,
      :bank_address,
      :iban,
      :bic
    )
  end
end
