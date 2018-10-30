class CreateSubcontracts < ActiveRecord::Migration[5.1]
  def change
    create_table :subcontracts do |t|
      t.references :invoice, foreign_key: true
      t.references :partner, foreign_key: true

      t.timestamps
    end
  end
end
