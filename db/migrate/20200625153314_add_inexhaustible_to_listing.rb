class AddInexhaustibleToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :inexhaustible, :boolean, null: false, default: false
  end
end
