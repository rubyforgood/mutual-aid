class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :name
      t.string :description
      t.date :display_date_start
      t.date :display_date_end

      t.timestamps
    end
  end
end
