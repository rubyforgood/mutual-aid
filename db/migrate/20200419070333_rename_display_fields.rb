class RenameDisplayFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :announcements, :display_date_start, :publish_from
    rename_column :announcements, :display_date_end, :publish_until
  end
end
