class AddSubmissionToListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :submission, null: true, index: true, foreign_key: true
  end
end
