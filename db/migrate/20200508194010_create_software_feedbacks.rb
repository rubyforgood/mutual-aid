class CreateSoftwareFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :software_feedbacks do |t|
      t.references :created_by, null: true, foreign_table_name: :users
      t.string :feedback_type
      t.string :module_name
      t.string :page_url
      t.string :name, null: false
      t.string :urgency
      t.integer :urgency_order
      t.string :notes
      t.boolean :completed, null: false, index: true, default: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end
