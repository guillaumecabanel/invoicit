class CreateBankAccountStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_account_statements do |t|
      t.string :bank_code
      t.string :counter_number
      t.string :account_number
      t.string :key
      t.string :currency
      t.string :bank_address
      t.string :iban
      t.string :bic

      t.timestamps
    end
  end
end
