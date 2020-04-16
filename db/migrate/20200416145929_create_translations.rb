class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.string :translatable_type
      t.string :translatable_id
      t.string :english_text
      t.string :translated_text
      t.string :submitted_by
      t.boolean :approved

      t.timestamps
    end
  end
end
