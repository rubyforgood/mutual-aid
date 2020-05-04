class AddPreferredLocaleToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :preferred_locale, :string, null: false, default: "en"
  end
end
