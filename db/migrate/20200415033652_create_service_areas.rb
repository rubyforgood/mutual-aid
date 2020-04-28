class CreateServiceAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :service_areas do |t|
      t.references :parent, null: true, index: true, foreign_table_name: :service_areas
      t.references :organization, null: true, index: true, foreign_key: true
      t.string :service_area_type

      t.string :name, index: true
      t.string :description

      t.boolean :display_to_public, null: false, default: true, index: true
      t.integer :display_order, null: false, default: 10, index: true
      t.boolean :is_created_by_admin, null: false, default: false, index: true

      t.timestamps
    end
  end
end
