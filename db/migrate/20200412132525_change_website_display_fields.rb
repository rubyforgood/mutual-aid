class ChangeWebsiteDisplayFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :external_resources, :display_on_website, :boolean
    add_column :external_resources, :display_on_website_start, :date
    add_column :external_resources, :display_on_website_end, :date
  end
end
