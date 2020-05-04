class AddFieldsToCommunicationLog < ActiveRecord::Migration[6.0]
  def change
    rename_column :communication_logs, :channel, :delivery_channel

    add_column :communication_logs, :delivery_status, :string
    add_column :communication_logs, :subject, :string
    add_column :communication_logs, :body, :json, default: []

    add_reference :communication_logs, :created_by, null: false, default: true
  end
end
