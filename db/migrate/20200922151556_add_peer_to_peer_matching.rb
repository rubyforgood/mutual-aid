class AddPeerToPeerMatching < ActiveRecord::Migration[6.0]
  def change
    add_column :system_settings, :allow_peer_to_peer_matching, :boolean, null: false, default: false
  end
end
