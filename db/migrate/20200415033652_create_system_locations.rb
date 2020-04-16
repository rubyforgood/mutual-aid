class CreateSystemLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :system_locations do |t|
      t.references :parent, null: false, foreign_table_name: :system_locations
      t.references :organization, null: false, foreign_key: true
      t.string :location_type
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :county
      t.string :region
      t.string :neighborhood

      t.timestamps
    end
  end
end
