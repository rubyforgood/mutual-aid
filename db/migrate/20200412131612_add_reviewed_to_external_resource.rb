class AddReviewedToExternalResource < ActiveRecord::Migration[6.0]
  def change
    add_column :external_resources, :reviewed, :boolean, null: false, default: false, index: true
  end
end
