class AddAmountToSubcontracts < ActiveRecord::Migration[5.1]
  def change
    add_monetize :subcontracts, :amount, currency: { present: false }
  end
end
