class AddApprovedToAnnouncement < ActiveRecord::Migration[6.0]
  def change
    add_column :announcements, :is_approved, :boolean
  end
end
