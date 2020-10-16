class AddOfferDefaultsToSystemSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :system_settings, :offer_defaults, :string
  end
end
