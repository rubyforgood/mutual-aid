class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.references :match, null: false, index: true, foreign_key: true
      t.boolean :is_from_receiver, null: false, default: true
      t.boolean :completed, null: false, default: false
      t.integer :quality
      t.text :description

      t.timestamps
    end
  end
end
