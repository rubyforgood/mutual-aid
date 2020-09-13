FactoryBot.define do
  factory :contact_method, aliases: [:contact_method_call] do
    name    { 'Call' }
    field   { 'phone' }
    enabled { true }

    factory :contact_method_text do
      name  { 'Text' }
      field { 'phone' }
    end

    factory :contact_method_email do
      name  { 'Email' }
      field { 'email' }
    end
  end
end

# == Schema Information
#
# Table name: contact_methods
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(TRUE), not null
#  field      :string
#  icon_class :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contact_methods_on_enabled  (enabled)
#
