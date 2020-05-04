class UpdateLocationAssociations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :locations, :service_area, null: true, foreign_key: true, index: true

    add_reference :people, :location, null: true, index: true, foreign_key: true
    add_reference :organizations, :location, null: true, index: true, foreign_key: true
  end
end
