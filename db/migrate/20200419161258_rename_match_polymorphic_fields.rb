class RenameMatchPolymorphicFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :matches, :asker_id, :receiver_id
    rename_column :matches, :owner_id, :provider_id

    rename_column :matches, :asker_type, :receiver_type
    rename_column :matches, :owner_type, :provider_type
  end
end
