class ChangeTypeForSentAtToInvoices < ActiveRecord::Migration[5.1]
  def change
    change_column :invoices, :sent_at, :datetime
  end
end
