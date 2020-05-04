class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.references :person, null: false, foreign_key: true
      t.references :service_area, null: false, foreign_key: true
      t.string :form_name
      t.string :privacy_level_requested
      t.text :body

      t.timestamps
    end
  end
end
