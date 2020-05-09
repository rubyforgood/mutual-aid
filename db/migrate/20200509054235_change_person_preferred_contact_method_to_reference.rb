class ChangePersonPreferredContactMethodToReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :people, :preferred_contact_method, :integer
    add_column :people, :preferred_contact_method_id, :integer
  end
end
