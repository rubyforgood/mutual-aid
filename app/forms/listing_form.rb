class ListingForm < Reform::Form
  DEFAULT_TAGS = [
    'prepared meals',
    'groceries',
    'household supplies',
    'cleaning',
    'laundry',
    'home repairs',
    'yard work',
    'childcare',
    'dog walking',
    'pet sitting',
    'emotional support',
    'religious support',
    'errands',
    'transportation',
    'making calls',
    'tech support',
    'translation',
    'cash',
  ]

  collection :tags

  property :location, form: LocationForm

  def self.all_tags
    DEFAULT_TAGS | Listing.all_tags
  end
end
