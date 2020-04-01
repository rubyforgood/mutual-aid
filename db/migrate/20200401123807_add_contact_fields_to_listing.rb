class AddContactFieldsToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :name, :string
    add_column :listings, :email, :string
    add_column :listings, :phone, :string
  end
end
