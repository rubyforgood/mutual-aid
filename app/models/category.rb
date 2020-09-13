class Category < ApplicationRecord
  belongs_to(:parent,
    class_name: "Category",
    inverse_of: :categories,
    optional: true,
  )
  has_many(:categories, -> { order(:display_order, :name) },
    class_name: "Category",
    foreign_key: :parent_id,
    inverse_of: :parent
  )

  validates :name, presence: true

  scope :visible, -> { where(display_to_public: true) }
  scope :roots,   -> { where(parent: nil).order(:display_order, :name) }

  # Currently only filtering by top-level categories
  scope :as_filter_types, -> { roots.select(:id, :name)}

  def full_name
    "#{ parent&.name&.upcase + ": " if parent}#{parent.present? ? name : name.upcase }"
  end

  def lineage
    own = [name]
    parent ? parent.lineage + own : own
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
