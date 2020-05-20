class CreateShiftMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_matches do |t|
      t.references :shift, null: false, index: true, foreign_key: true
      t.references :match, null: false, index: true, foreign_key: true

      t.string :notes

      t.timestamps
    end
  end
end
