class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.references :person, null: true, foreign_key: true, index: true
      t.references :organization, null: true, foreign_key: true, index: true
      t.string :position_type
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.boolean :is_primary, null: false, default: false
      t.text :notes

      t.timestamps
    end
  end
end
