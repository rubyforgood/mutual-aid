class RenameOrganizationIsInstanceOwnerToHostOrganization < ActiveRecord::Migration[6.0]
  def change
    rename_column :organizations, :is_instance_owner, :is_host
  end
end
