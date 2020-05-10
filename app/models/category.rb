class Category < ApplicationRecord
  belongs_to(:parent,
    class_name: "Category",
    inverse_of: :categories,
    optional: true,
  )
  has_many(:categories, -> { order :display_order },
    class_name: "Category",
    foreign_key: :parent_id,
    inverse_of: :parent
  )

  scope :visible, -> { where(display_to_public: true) }
  scope :roots,   -> { where(parent: nil) }

  def full_name
    "#{ parent&.name&.upcase + ": " if parent}#{parent.present? ? name : name.upcase }"
  end
end
