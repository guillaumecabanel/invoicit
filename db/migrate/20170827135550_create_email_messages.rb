class CreateEmailMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :email_messages do |t|
      t.string :subject
      t.text :content
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
