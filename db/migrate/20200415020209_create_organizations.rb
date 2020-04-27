class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :short_name
      t.string :description
      t.string :facebook_url
      t.string :website_url
      t.string :phone
      t.boolean :is_instance_owner, null: false, default: true
      t.boolean :has_sms_account, null: false, default: false
      t.boolean :has_hosting_account, null: false, default: false
      t.boolean :has_mailer_account, null: false, default: false

      t.timestamps
    end
  end
end
