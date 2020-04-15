class CreateSystemTags < ActiveRecord::Migration[6.0]
  def change
    create_table :system_tags do |t|
      t.string :name, null: false, index: true
      t.string :description, index: true
      t.boolean :display_to_public, null: false, default: true, index: true
      t.integer :display_order, null: false, default: 10, index: true

      t.string :created_by

      t.references :parent, null: true, index: true, foreign_table_name: :system_tags
      t.string :parent_type, null: true, index: true

      t.timestamps
    end
  end
end
