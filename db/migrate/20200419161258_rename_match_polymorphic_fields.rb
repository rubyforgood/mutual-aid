class RenameMatchPolymorphicFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :matches, :asker_id, :matchable_asker_id
    rename_column :matches, :owner_id, :matchable_offerer_id

    rename_column :matches, :asker_type, :matchable_asker_type
    rename_column :matches, :owner_type, :matchable_offerer_type
  end
end
