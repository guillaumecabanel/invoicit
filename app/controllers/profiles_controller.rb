class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update(user_params)
      if @user.bank_account_statement.nil?
       redirect_to new_bank_account_statement_path
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :company_name,
      :company_street,
      :company_postal_code,
      :company_city,
      :company_siret,
      :company_rcs
    )
  end

  def set_user
    @user = current_user
    authorize @user
  end
end
