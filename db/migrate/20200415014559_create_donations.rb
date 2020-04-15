class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.references :person, null: false, foreign_key: true
      t.float :value
      t.string :channel
      t.string :thank_you_sent
      t.text :notes

      t.timestamps
    end
  end
end
