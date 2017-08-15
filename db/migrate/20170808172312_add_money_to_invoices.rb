class AddMoneyToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_monetize :invoices, :amount, currency: { present: false }
    add_monetize :invoices, :amount_with_vat, currency: { present: false }
  end
end
