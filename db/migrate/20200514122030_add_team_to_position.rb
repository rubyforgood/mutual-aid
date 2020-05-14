class AddTeamToPosition < ActiveRecord::Migration[6.0]
  def change
    add_reference :positions, :team, null: true, index: true, foreign_key: true
  end
end
