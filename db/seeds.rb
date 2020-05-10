### Seeds are idempotent, and should be created in dev and prod

# create a base user using ENV vars
# we currently have Devise :confirmable strategy turned on, so all new users need their email confirmed
User.where(email: "#{ENV["SYSTEM_EMAIL"]}").first_or_create!(
  password: "#{ENV["SYSTEM_PASSWORD"]}",
  confirmed_at: Time.current,
)

# create categories from model constant -- these are then editable by admin users
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
DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent).first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name).first_or_create!
  end
end

%w[neighborhood pod region county].each do |location_type_name|
  LocationType.where(name: location_type_name).first_or_create!
end

# we need at least one ServiceArea
location_type = LocationType.first
location = Location.new(location_type: location_type)
ServiceArea.where(name: 'Default service area (change or delete me)').first_or_create!(location: location)

# host org and set system defaults
SystemSetting.first_or_create!

host_organization = Organization.where(is_instance_owner: true).first_or_create!(name: "[CHANGEME] Default Mutual Aid Group")

# these positions are needed for Submission confirmation autoemails
Position.where(position_type: Position::ASK_FORM_CONTACT_TITLE, organization: host_organization).first_or_create!
Position.where(position_type: Position::OFFER_FORM_CONTACT_TITLE, organization: host_organization).first_or_create!
Position.where(position_type: Position::COMMUNITY_RESOURCES_CONTACT_TITLE, organization: host_organization).first_or_create!

# create system locales. all are set to show up in dropdowns and
locales_file = Rails.root.join('config', 'locales', 'locales.yml')
yml_data = YAML::load_file(locales_file)
locales = yml_data["vendor"]["iso"]["languages"]

locales.each do |locale, locale_name|
  SystemLocale.where(locale: locale).first_or_create!(locale_name: locale_name)
end

[['Call', 'phone'], ['Text', 'phone'], ['Email', 'email'], ['WhatsApp', 'phone']].each do |(name, field)|
  ContactMethod.exists?(name: name) || ContactMethod.create!(name: name, field: field)
end

puts "completed seeds.rb"
