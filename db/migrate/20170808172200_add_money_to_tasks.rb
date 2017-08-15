class AddMoneyToTasks < ActiveRecord::Migration[5.1]
  def change
    add_monetize :tasks, :unit_price, currency: { present: false }
    add_monetize :tasks, :price_without_vat, currency: { present: false }
    add_monetize :tasks, :vat, currency: { present: false }
    add_monetize :tasks, :price_with_vat, currency: { present: false }
  end
end
