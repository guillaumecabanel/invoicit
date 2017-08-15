class AddCompanyInfosToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :company_street, :string
    add_column :users, :company_postal_code, :string
    add_column :users, :company_city, :string
    add_column :users, :company_siret, :string
    add_column :users, :company_rcs, :string
  end
end
