class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :asker_type
      t.integer :asker_id
      t.string :status
      t.string :notes
      t.boolean :tentative
      t.boolean :completed

      t.timestamps
    end
  end
end
