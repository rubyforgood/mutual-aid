class UpdateServiceAreaAssociations < ActiveRecord::Migration[6.0]
  def change
    add_reference :people, :service_area, null: true, index: true, foreign_key: true
    add_reference :organizations, :service_area, null: true, index: true, foreign_key: true
  end
end
