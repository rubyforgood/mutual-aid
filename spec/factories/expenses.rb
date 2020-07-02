FactoryBot.define do
  factory :expense do
    account { "MyString" }
    processed_on { "2020-06-29" }
    name { "MyString" }
    person { nil }
    expense_type { "MyString" }
    status { "MyString" }
    amount { 1.5 }
    fee { 1.5 }
    net { 1.5 }
    transaction_id { "MyString" }
    reference_txn_id { "MyString" }
    note { "MyString" }
    organization { nil }
  end
end
