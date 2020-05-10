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

  # TODO: i don't think these should live here
  DEFAULT_TAGS = [
      ['meals', 'prepared meals'],
      ['meals', 'groceries'],
      ['errands', 'and deliveries'],
      ['care', 'childcare'],
      ['care', 'animal care'],
      ['care', 'elder or disability care'],
      ['services', 'tech support'],
      ['services', 'translation'],
      ['services', 'accessing unemployment'],
      ['services', 'accessing healthcare'],
      ['services', 'transportation'],
      ['services', 'housework'],
      ['services', 'yardwork'],
      ['services', 'laundry'],
      ['supplies', 'household'],
      ['supplies', 'clothing'],
      ['support', 'emotional'],
      ['support', 'religious'],
      ['housing', 'temporary'],
      ['housing', 'permanent'],
      ['housing', 'storage'],
      ['cash', ''],
  ]

  scope :visible, -> { where(display_to_public: true) }
  scope :roots,   -> { where(parent: nil) }

  def full_name
    "#{ parent&.name&.upcase + ": " if parent}#{parent.present? ? name : name.upcase }"
  end
end
