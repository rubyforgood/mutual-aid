class DropTitleFromListings < ActiveRecord::Migration[6.0]
  def change
    remove_column :listings, :title, :string
    remove_column :listings, :description, :text
  end
end
