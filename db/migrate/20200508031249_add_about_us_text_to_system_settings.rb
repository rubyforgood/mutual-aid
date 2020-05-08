class AddAboutUsTextToSystemSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :system_settings, :about_us_text, :text
  end
end
