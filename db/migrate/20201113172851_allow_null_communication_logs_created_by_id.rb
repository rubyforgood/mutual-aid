class AllowNullCommunicationLogsCreatedById < ActiveRecord::Migration[6.0]
  def change
    change_column :communication_logs, :created_by_id, :bigint, default: nil, null: true
  end
end
