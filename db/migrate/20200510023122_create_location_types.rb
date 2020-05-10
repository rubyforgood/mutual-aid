class CreateLocationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :location_types do |t|
      t.string :name
      t.string :description
      t.boolean :display_to_public, null: false, default: false, index: true

      t.timestamps
    end
  end
end
