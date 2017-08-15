class AddTitleToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :title, :string
  end
end
