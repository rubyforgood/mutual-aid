class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.references :person, null: false, index: true, foreign_key: true
      t.references :team, null: false, index: true, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.text :notes

      t.timestamps
    end
  end
end
