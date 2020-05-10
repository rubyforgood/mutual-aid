class AddLocationAssnToServiceArea < ActiveRecord::Migration[6.0]
  def change
    add_reference :service_areas, :location, null: false, index: true, foreign_key: true
  end
end
