class LocationForm < Reform::Form
  CITIES = [
    'Acme Township',
    'Blair Township',
    'East Bay Township',
    'Fife Lake / Fife Lake Township',
    'Garfield Township',
    'Grant Township',
    'Green Lake Township',
    'Kingsley / Paradise Township',
    'Long Lake Township',
    'Mayfield Township',
    'Peninsula Township',
    'Traverse City',
    'Union Township',
    'Whitewater Township',
  ]

  property :street_address
  property :city
  property :state
  property :zip

  validates :zip, numericality: {only_integer: true, allow_blank: true, allow_nil: true},
                  length: {is: 5, allow_blank: true, allow_nil: true}
end
