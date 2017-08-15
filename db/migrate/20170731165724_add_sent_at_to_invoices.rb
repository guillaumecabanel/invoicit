class AddSentAtToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :sent_at, :date
  end
end
