class AddRoleToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :role, :string, default: 'unset'
    add_index :users, :role
  end

  def down
    remove_column :users, :role
  end
end
