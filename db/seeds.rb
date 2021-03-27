### Seeds are idempotent, and should be created in dev and prod

# create a base user using ENV vars
# we currently have Devise :confirmable strategy turned on, so all new users need their email confirmed
User.where(email: "#{ENV["SYSTEM_EMAIL"]}").first_or_create!(
  password: "#{ENV["SYSTEM_PASSWORD"]}",
  confirmed_at: Time.current,
  role: "sys_admin"
)

# create categories -- these are then editable by admin users
# TODO: i don't think these should live here
default_tags = [
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
default_tags.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent).first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name).first_or_create!
  end
end

%w[business home cross_street service_area park].each do |location_type_name|
  location_type = LocationType.where(name: location_type_name).first_or_create!
  unless location_type_name == "service_area"
    location_type.update_attributes(display_to_public: true)
  end
end

# host org and set system defaults
SystemSetting.first_or_create!(exchange_type: "fully_moderated")

host_organization = Organization.where(is_instance_owner: true).first_or_create!(name: "[CHANGEME] Default Mutual Aid Group")

# we need at least one ServiceArea, and every service_area gets its own location
location_type = LocationType.first
location = Location.new(location_type: location_type)
ServiceArea.where(name: 'Default service area (change or delete me)', organization: host_organization, service_area_type: ServiceArea::TYPES.sample).first_or_create!(location: location)

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

[ ['Call', 'phone', 'fa fa-phone'],
  ['Text', 'phone', 'fa fa-comment'],
  ['Email', 'email', 'fa fa-envelope'],
  ['WhatsApp', 'phone', 'fa fa-whatsapp'],
  # ['Instagram', 'notes', 'fa fa-instagram'], # TODO - enable social media options
  # ['Facebook', 'notes', 'fa fa-facebook'],
  # ['Twitter', 'notes', 'fa fa-twitter'],
].
  each do |(name, field, icon_class)|
    ContactMethod.find_or_create_by!(name: name, field: field, enabled: true, icon_class: icon_class)
  end

[Ask, Offer].each do |type|
  next if Form.exists? contribution_type_name: type.name

  form = Form.create!(
    name: type.name,
    contribution_type_name: type.name,
    display_categories: true,
    organization: host_organization,
  )

  form.update(
    header_html: %|<p>This is some PLACEHOLDER header text.</p>\n<p>You can <a href="/forms/#{form.id}/edit">change it here</a>.</p>|,
    footer_html: %|<p>This is some PLACEHOLDER footer text.</p>\n<p>You can <a href="/forms/#{form.id}/edit">change it here</a>.</p>|,
  )
end

puts "completed seeds.rb"
