class CombineNameFieldsOnPerson < ActiveRecord::Migration[6.0]
  def change
    rename_column :people, :last_name, :name
    remove_column :people, :first_name, :string, index: true
  end
end
