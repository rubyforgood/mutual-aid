class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.references :parent, null: true, index: true, foreign_table_name: :categories

      t.string :name, null: false, index: true
      t.string :description, index: true

      t.boolean :display_to_public, null: false, default: true, index: true
      t.integer :display_order, null: false, default: 10, index: true
      t.boolean :is_created_by_admin, null: false, default: false, index: true

      t.timestamps
    end
  end
end
