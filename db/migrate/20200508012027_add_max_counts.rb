class AddMaxCounts < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :monthly_matches_max, :integer, default: 0
    add_column :people, :monthly_donation_amount_max, :float, default: 0.0
  end
end
