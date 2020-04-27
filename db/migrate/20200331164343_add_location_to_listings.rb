class AddLocationToListings < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :location, foreign_key: true, index: true
  end
end
