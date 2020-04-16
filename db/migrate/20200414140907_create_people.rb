class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :phone_2
      t.string :email_2
      t.string :preferred_contact_method
      t.string :preferred_contact_timeframe
      t.text :skills
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
