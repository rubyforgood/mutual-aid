class ReplacePositionFkToLocation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :positions, :location, foreign_key: true, index: true
    add_reference :positions, :organization, foreign_key: true, index: true
  end
end
