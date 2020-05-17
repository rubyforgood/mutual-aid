class DisplayOnOrgChart < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :display_on_org_chart, :boolean, null: false, default: true, index: true
    add_column :teams, :display_on_org_chart, :boolean, null: false, default: true, index: true
    add_column :positions, :display_on_org_chart, :boolean, null: false, default: true, index: true
  end
end
