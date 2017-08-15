class AddPaidAtToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :paid_at, :date
  end
end
