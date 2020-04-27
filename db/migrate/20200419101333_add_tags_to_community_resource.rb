class AddTagsToCommunityResource < ActiveRecord::Migration[6.0]
  def change
    add_column :community_resources, :tags, :string, array: true, default: []
    add_index :community_resources, :tags, using: "gin"
  end
end
