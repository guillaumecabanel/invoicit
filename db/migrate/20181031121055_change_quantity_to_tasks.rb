class ChangeQuantityToTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :quantity, :float
  end
end
