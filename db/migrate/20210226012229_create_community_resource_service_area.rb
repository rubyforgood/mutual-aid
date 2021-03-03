class CreateCommunityResourceServiceArea < ActiveRecord::Migration[6.0]
  def change
    create_table :community_resource_service_areas do |t|
      t.references :community_resource, null: false, index: true, foreign_key: true
      t.references :service_area, null: false, index: true, foreign_key: true
    end
  end
end
