class CreateSystemLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :system_locations do |t|
      t.string :street_address
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 5

      t.string :region, index: true
      t.string :neighborhood, index: true
      t.string :county, index: true

      t.string :location_type

      t.references :parent, null: true, index: true, foreign_table_name: :system_locations

      t.timestamps
    end
  end
end
