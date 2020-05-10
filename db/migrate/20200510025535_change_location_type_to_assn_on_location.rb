class ChangeLocationTypeToAssnOnLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :locations, :locationable, polymorphic: true
    remove_column :locations, :location_type, :string
    add_reference :locations, :location_type, index: true, null: false, foreign_key: true # will require db drop/truncate table data if existing data
  end
end
