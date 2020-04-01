class AddTagsToExternalResource < ActiveRecord::Migration[6.0]
  def change
    add_column :external_resources, :tags, :string, array: true, default: []
    add_index :external_resources, :tags, using: "gin"
  end
end
