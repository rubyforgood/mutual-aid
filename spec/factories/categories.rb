FactoryBot.define do
  factory :category do
    name { "MyString" }
    parent { nil }
    description { "MyText" }
    display_to_public { false }
    display_order { 1 }
    is_created_by_admin { false }
  end
end

# == Schema Information
#
# Table name: categories
#
#  id                  :bigint           not null, primary key
#  description         :string
#  display_order       :integer          default(10), not null
#  display_to_public   :boolean          default(TRUE), not null
#  is_created_by_admin :boolean          default(FALSE), not null
#  name                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  parent_id           :bigint
#
# Indexes
#
#  index_categories_on_description          (description)
#  index_categories_on_display_order        (display_order)
#  index_categories_on_display_to_public    (display_to_public)
#  index_categories_on_is_created_by_admin  (is_created_by_admin)
#  index_categories_on_name                 (name)
#  index_categories_on_parent_id            (parent_id)
#
