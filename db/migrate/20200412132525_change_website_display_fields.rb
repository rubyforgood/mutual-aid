class ChangeWebsiteDisplayFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :external_resources, :display_on_website, :boolean
    add_column :external_resources, :display_on_website_start, :date
    add_column :external_resources, :display_on_website_end, :date
  end
end

# create_table :system_tags do |t|
#   t.references :organization, null: true, index: true, foreign_key: true
#   t.references :parent, null: true, index: true, foreign_table_name: :system_tags
#   t.string :parent_type, null: true, index: true
#
#   t.string :name, null: false, index: true
#   t.string :description, index: true
#   t.boolean :display_to_public, null: false, default: true, index: true
#   t.integer :display_order, null: false, default: 10, index: true
#
#   t.string :created_by
#
#   t.timestamps
# end