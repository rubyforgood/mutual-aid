class AddServiceAreaToLocations < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :service_area, foreign_key: true, index: true
  end
end
