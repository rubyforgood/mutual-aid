class UpdateListingsAssociations < ActiveRecord::Migration[6.0]
  def change
<<<<<<< HEAD
    add_reference :listings, :person, null: false, index: true, foreign_key: true # will require db drop of existing Listing data
    add_reference :listings, :service_area, null: false, index: true, foreign_key: true # will require db drop of existing Listing data

    # removing & adding in order to change to null:true
    remove_reference :listings, :location, null: false, index: true, foreign_key: true
=======
    add_reference :listings, :person, null: false, index: true, foreign_key: true, default: 1 # TODO - we'd need to figure this out...
    add_reference :listings, :service_area, null: false, index: true, foreign_key: true, default: 1 # TODO - need to drop db's rather than set default here?
    remove_reference :listings, :location, null: true, index: true, foreign_key: true
>>>>>>> ca7c148... WIP: stubbing out Profile page and some other admin pages
    add_reference :listings, :location, null: true, index: true, foreign_key: true
  end
end
