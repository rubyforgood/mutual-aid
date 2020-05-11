class RemoveConstraintOnTranslatedModels < ActiveRecord::Migration[6.0]
  def change
    change_column :community_resources, :name, :string, null: true
  end
end
