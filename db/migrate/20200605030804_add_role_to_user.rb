class AddRoleToUser < ActiveRecord::Migration[6.0]
def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('unset', 'neighbor', 'volunteer', 'dispatcher', 'admin', 'sys_admin');
    SQL
    add_column :users, :role, :user_role, default: :unset
    add_index :users, :role
  end

  def down
    remove_column :users, :role
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end