class ChangeCommunicationLogsBodyFieldType < ActiveRecord::Migration[6.0]
  def change
    remove_column :communication_logs, :body, :json, default: []
    add_column :communication_logs, :body, :string
  end
end
