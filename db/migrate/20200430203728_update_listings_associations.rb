class UpdateListingsAssociations < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :person, null: false, index: true, foreign_key: true # will require db drop of existing Listing data
    add_reference :listings, :service_area, null: false, index: true, foreign_key: true # will require db drop of existing Listing data

    # removing & adding in order to change to null:true
    remove_reference :listings, :location, null: false, index: true, foreign_key: true
    add_reference :listings, :location, null: true, index: true, foreign_key: true
  end
end
