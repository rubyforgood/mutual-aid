class ChangeReferencesOnExternalResource < ActiveRecord::Migration[6.0]
  def change
    remove_reference :external_resources, :location, foreign_key: true, index: true
    add_reference :external_resources, :system_location, null: true, foreign_key: true, index: true
    add_reference :external_resources, :organization, null: true, foreign_key: true, index: true
  end
end
