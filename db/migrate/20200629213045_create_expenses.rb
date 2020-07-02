class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.references :expense_type, null: false, index: true, foreign_key: true
      t.references :shared_account, null: false, index: true, foreign_key: true
      t.date :processed_on
      t.string :name
      t.references :person, null: true, index: true, foreign_key: true
      t.string :expense_type
      t.string :status
      t.float :amount
      t.float :fee
      t.float :net
      t.string :transaction_id_number
      t.string :reference_txn_id_number
      t.string :note
      t.references :organization, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
