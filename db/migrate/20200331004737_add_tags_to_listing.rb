class AddTagsToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :tags, :text, array: true, default: []

    add_index  :listings, :tags, using: "gin"
  end
end
