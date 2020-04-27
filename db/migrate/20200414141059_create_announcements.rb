class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :name
      t.text :description
      t.date :publish_from
      t.date :publish_until
      t.boolean :is_approved, null: false, default: false

      t.timestamps
    end
  end
end
