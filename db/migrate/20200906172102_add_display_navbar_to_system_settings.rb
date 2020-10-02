class AddDisplayNavbarToSystemSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :system_settings, :display_navbar, :boolean, default: false
  end
end
