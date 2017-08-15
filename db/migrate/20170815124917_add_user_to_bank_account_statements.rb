class AddUserToBankAccountStatements < ActiveRecord::Migration[5.1]
  def change
    add_reference :bank_account_statements, :user, foreign_key: true
  end
end
