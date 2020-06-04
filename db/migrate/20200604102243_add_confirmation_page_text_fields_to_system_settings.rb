class AddConfirmationPageTextFieldsToSystemSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :system_settings, :confirmation_page_text_header, :string
    add_column :system_settings, :confirmation_page_text_body, :string
    add_column :system_settings, :confirmation_page_text_link_header, :string
    add_column :system_settings, :confirmation_page_text_footer, :string
  end
end
