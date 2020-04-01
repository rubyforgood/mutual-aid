class RenameLocationStreet < ActiveRecord::Migration[6.0]
  def change
    rename_column :locations, :street, :street_address
  end
end
