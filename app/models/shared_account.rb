class SharedAccount < ApplicationRecord
end

# == Schema Information
#
# Table name: shared_accounts
#
#  id            :bigint           not null, primary key
#  account_url   :string
#  name          :string
#  notes         :string
#  password_hint :string
#  username      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
