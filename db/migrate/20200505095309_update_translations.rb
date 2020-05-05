class UpdateTranslations < ActiveRecord::Migration[6.0]
  def change
    add_reference :mobility_text_translations, :created_by, null: true, foreign_table_name: :users, index: true
    add_column :mobility_text_translations, :is_approved, :boolean, null: false, default: true

    add_reference :mobility_string_translations, :created_by, null: true, foreign_table_name: :users, index: true
    add_column :mobility_string_translations, :is_approved, :boolean, null: false, default: true
  end
end
