class RemoveUserDependencyOnPerson < ActiveRecord::Migration[6.0]
  def change
    remove_reference :people, :user, null: true, index: true, foreign_key: true
  end
end
