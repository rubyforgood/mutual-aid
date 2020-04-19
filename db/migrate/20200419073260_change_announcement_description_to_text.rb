class ChangeAnnouncementDescriptionToText < ActiveRecord::Migration[6.0]
  def up
    change_column :announcements, :description, :text
  end

  def down
    change_column :announcements, :description, :string
  end
end
