class Expense < ApplicationRecord
  belongs_to :expense_type
  belongs_to :person, optional: true
  belongs_to :organization
  belongs_to :shared_account
end
