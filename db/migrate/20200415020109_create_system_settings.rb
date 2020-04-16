class CreateSystemSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :system_settings do |t|
      t.string :exchange_type
      t.boolean :separate_asks_offers
      t.boolean :allow_sms
      t.boolean :community_resources_module
      t.boolean :announcements_module
      t.boolean :positions_module
      t.boolean :donations_module
      t.boolean :shared_accounts_module
      t.boolean :chat_module
      t.text :landing_page_text_what
      t.text :landing_page_text_who
      t.text :landing_page_text_how

      t.timestamps
    end
  end
end
