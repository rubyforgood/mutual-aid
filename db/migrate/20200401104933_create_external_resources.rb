class CreateExternalResources < ActiveRecord::Migration[6.0]
  def change
    create_table :external_resources do |t|
      t.string :name, null: false
      t.string :website_url
      t.string :facebook_url
      t.string :phone
      t.string :description
      t.boolean :display_on_website, null: false, default: true, index: true
      t.string :youtube_identifier
      t.references :location, null: true,index: true, foreign_key: true

      t.timestamps
    end
  end
end
