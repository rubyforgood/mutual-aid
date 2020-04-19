class RenameDisplayFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :announcements, :display_date_start, :publish_from
    rename_column :announcements, :display_date_end, :publish_until

    rename_column :external_resources, :reviewed, :approved
    rename_column :external_resources, :display_on_website_start, :publish_from
    rename_column :external_resources, :display_on_website_end, :publish_until
  end
end
