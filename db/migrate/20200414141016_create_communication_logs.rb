class CreateCommunicationLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :communication_logs do |t|
      t.references :person, null: false, foreign_key: true
      t.string :channel
      t.datetime :sent_at
      t.boolean :needs_follow_up

      t.timestamps
    end
  end
end
