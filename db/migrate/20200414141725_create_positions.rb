class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.references :location, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.string :position_type
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.boolean :is_primary
      t.text :notes

      t.timestamps
    end
  end
end
