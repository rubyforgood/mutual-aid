class ChangeCommunicationLogFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :communication_logs, :from_type, :string
    remove_column :communication_logs, :to_type, :string
    add_column :communication_logs, :outbound, :boolean, null: false, default: true, index: true

    remove_column :communication_logs, :delivery_channel, :string
    add_reference :communication_logs, :delivery_method, null: false, index: true, foreign_table_name: :contact_methods
  end
end
