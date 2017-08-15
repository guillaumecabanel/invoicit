class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :title
      t.string :address_street
      t.string :address_postal_code
      t.string :address_city
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email
      t.string :contact_phone_number

      t.timestamps
    end
  end
end
