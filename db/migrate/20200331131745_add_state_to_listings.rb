class AddStateToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :state, :integer, default: 0
  end
end
