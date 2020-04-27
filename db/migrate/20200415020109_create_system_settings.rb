class CreateSystemSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :system_settings do |t|
      t.string :exchange_type, null: false, default: "peer_to_peer"
      t.boolean :separate_asks_offers, null: false, default: true
      t.boolean :community_resources_module, null: false, default: true
      t.boolean :announcements_module, null: false, default: true
      t.boolean :donations_module, null: false, default: true
      t.boolean :positions_module, null: false, default: true
      t.boolean :shared_accounts_module, null: false, default: true

      t.boolean :allow_sms, null: false, default: false
      t.boolean :chat_module, null: false, default: true
      t.text :landing_page_text_what
      t.text :landing_page_text_who
      t.text :landing_page_text_how

      t.timestamps
    end
  end
end
