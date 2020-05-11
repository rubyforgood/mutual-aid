class CreateHistoryLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :history_logs do |t|
      t.string :topic
      t.string :name

      t.timestamps
    end
  end
end
