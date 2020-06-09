class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.string :contribution_type_name
      t.string :name
      t.string :header_html
      t.string :footer_html
      t.boolean :display_categories
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
