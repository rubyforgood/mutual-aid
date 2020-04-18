class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.string :facebook_url
      t.string :website_url
      t.string :phone
      t.references :point_of_contact, null: true, foreign_table_name: :people
      t.boolean :is_instance_owner
      t.boolean :has_sms_account
      t.boolean :has_hosting_account
      t.boolean :has_mailer_account

      t.timestamps
    end
  end
end
