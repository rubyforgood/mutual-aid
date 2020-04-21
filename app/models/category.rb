class Category < ApplicationRecord
  belongs_to :parent, optional: true, class_name: "Category",foreign_key: :parent_id, inverse_of: :categories
  has_many :categories, as: :parent, class_name: "Category", foreign_key: :parent_id, inverse_of: :parent

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
      ['services', 'accessing healhcare'],
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

  def full_name
    "#{ parent&.name&.upcase + ": " if parent}#{parent.present? ? name : name.upcase }"
  end

end
