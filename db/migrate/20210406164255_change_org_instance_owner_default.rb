class ChangeOrgInstanceOwnerDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :organizations, :is_instance_owner, from: true, to: false
  end
end
