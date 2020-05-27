class AddExchangeTimeToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :exchanged_at, :datetime
  end
end
