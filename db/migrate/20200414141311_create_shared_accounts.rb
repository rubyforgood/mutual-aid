class CreateSharedAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :shared_accounts do |t|
      t.string :name
      t.string :account_url
      t.string :username
      t.string :password_hint
      t.string :notes

      t.timestamps
    end
  end
end
