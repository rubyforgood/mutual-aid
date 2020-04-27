class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :location_type
      t.string :street_address
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 5

      t.string :county
      t.string :region
      t.string :neighborhood

      t.timestamps
    end
  end
end
