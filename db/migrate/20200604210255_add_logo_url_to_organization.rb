class AddLogoUrlToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :logo_url, :string
    add_column :organizations, :favicon_url, :string
  end
end
