class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.references :message, foreign_key: true
      t.integer :receiver_id
      t.string :status

      t.timestamps
    end
  end
end
