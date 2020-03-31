class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 5

      t.timestamps
    end
  end
end
