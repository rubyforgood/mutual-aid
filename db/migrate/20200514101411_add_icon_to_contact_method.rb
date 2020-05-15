class AddIconToContactMethod < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_methods, :icon_class, :string
  end
end
