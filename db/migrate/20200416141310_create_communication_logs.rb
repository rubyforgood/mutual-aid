class CreateCommunicationLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_logs do |t|
      t.references :person, null: true, index: true, foreign_key: true
      t.references :match, null: true, index: true, foreign_key: true
      t.string :from_type
      t.string :to_type
      t.string :channel
      t.datetime :sent_at
      t.boolean :needs_follow_up, null: false, default: false

      t.timestamps
    end
  end
end
