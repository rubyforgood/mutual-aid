class DropZipFromListings < ActiveRecord::Migration[6.0]
  def change
    remove_column :listings, :zip, :string
  end
end
