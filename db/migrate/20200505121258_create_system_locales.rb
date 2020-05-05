class CreateSystemLocales < ActiveRecord::Migration[6.0]
  def change
    create_table :system_locales do |t|
      t.string :locale, null: false, index: true
      t.string :locale_name, null: false
      t.boolean :publish_in_dropdowns, null: false, index: true, default: true
      t.boolean :publish_translations, null: false, index: true, default: true

      t.timestamps
    end
  end
end
