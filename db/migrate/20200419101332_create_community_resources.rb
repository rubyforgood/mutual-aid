class CreateCommunityResources < ActiveRecord::Migration[6.0]
  def change
    create_table :community_resources do |t|
      t.references :service_area, null: true, foreign_key: true, index: true
      t.references :location, null: true, foreign_key: true, index: true
      t.references :organization, null: true, foreign_key: true, index: true

      t.string :name, null: false
      t.string :website_url
      t.string :facebook_url
      t.string :phone
      t.string :description
      t.date :publish_from
      t.date :publish_until
      t.boolean :is_created_by_admin, null: false, default: true, index: true
      t.boolean :is_approved, null: false, default: true, index: true
      t.string :youtube_identifier

      t.timestamps
    end
  end
end
