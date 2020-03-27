class AddZipCodeToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :zip, :string, null:false
  end
end
