class AddUrgencyLevelToListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :urgency_level
  end
end
