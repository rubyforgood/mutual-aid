class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :provider_id
      t.string :provider_type
      t.string :receiver_type
      t.integer :receiver_id
      t.string :status
      t.string :notes
      t.boolean :tentative, null: false, default: true
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
