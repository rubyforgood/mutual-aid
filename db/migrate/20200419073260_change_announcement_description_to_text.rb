class ChangeAnnouncementDescriptionToText < ActiveRecord::Migration[6.0]
  def change
    change_column :announcements, :description, :text
  end
end
