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
