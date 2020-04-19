class RemovePointOfContactFromOrganization < ActiveRecord::Migration[6.0]
  def change
    remove_reference :organizations, :point_of_contact, foreign_table_name: :positions, index: true
  end
end
