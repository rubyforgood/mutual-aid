# Seeds to provide testing/demos with some quick fake data
# to run this file manually run $ rails runner -e development db/dev_seeds.rb

require 'faker'

non_autoemail_contact_methods = ContactMethod.autoemail(false)

host_organization = Organization.where(is_instance_owner: true).first_or_create!(name: "[CHANGEME] Default Mutual Aid Group")

# rename default service_area
ServiceArea.first.update_attributes(name: Faker::Address.community, organization: host_organization, service_area_type: ServiceArea::TYPES.sample)

# create service areas
location_type = LocationType.all.sample
5.times do
  # every service_area gets its own location
  location = Location.new(location_type: location_type)
  ServiceArea.create!(name: Faker::Address.community, location: location, organization: host_organization, service_area_type: ServiceArea::TYPES)
end

email_contact_method = ContactMethod.where(ContactMethod.arel_table[:field].lower.eq('email')).first || ContactMethod.create!(name: "Email", field: "email")
phone_contact_method = ContactMethod.where(ContactMethod.arel_table[:field].lower.eq('phone')).first || ContactMethod.create!(name: "Call", field: "phone")

# people
person = Person.where(name: Faker::Name.name, preferred_contact_method: email_contact_method, email: Faker::Internet.email).first_or_create!
person_2 = Person.where(name: Faker::Name.name, preferred_contact_method: phone_contact_method, phone: Faker::PhoneNumber.phone_number).first_or_create!
city = Faker::Address.city
state = ["NY", "MI", "DC", "NC"].sample
10.times do
  location = Location.create!(street_address: Faker::Address.street_address, city: city, state: state, location_type: LocationType.all.sample)
  contact_method = non_autoemail_contact_methods.sample
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.phone_number
  Person.where(location: location,
               name: Faker::Name.name, 
               preferred_contact_method: contact_method,
               email: contact_method&.field.downcase == "email" ? email : [nil, email].sample,
               phone: contact_method&.field.downcase == "phone" ? phone : [nil, phone].sample,
               ).first_or_create!
end

# asks for person
Category.all.pluck(:name).sample(4).each do |tag|
  ask = Ask.where(person: person, service_area: ServiceArea.all.sample).create!
  ask.tag_list << tag
  ask.save!
end
# offers for person
Category.all.pluck(:name).sample(2).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.all.sample).create!
  offer.tag_list << tag
  offer.save!
end
# offers for person_2
Category.all.pluck(:name).sample(4).each do |tag|
  offer = Offer.where(person: person_2, service_area: ServiceArea.all.sample).create!
  offer.tag_list << tag
  offer.save!
end

# listings
5.times do
  Category.all.pluck(:name).sample(4).each do |tag|
    ask = Ask.where(person: Person.all.sample, service_area: ServiceArea.all.sample, created_at: Faker::Time.between(from: DateTime.now - 20.days, to: DateTime.now - 1.hour)).create!
    ask.tag_list << tag
    ask.save!

    # complimentary offer
    offer = Offer.where(person: Person.all.sample, service_area: ServiceArea.all.sample, created_at: Faker::Time.between(from: DateTime.now - 20.days, to: DateTime.now - 1.hour)).create!
    offer.tag_list << tag
    offer.save!
  end
  Category.all.pluck(:name).sample(4).each do |tag|
    offer = Offer.where(person: Person.all.sample, service_area: ServiceArea.all.sample, created_at: Faker::Time.between(from: DateTime.now - 20.days, to: DateTime.now - 1.hour)).create!
    offer.tag_list << tag
    offer.save!
  end
end  


# matches
#

match_1 = Match.where(receiver: person, provider: person_2.offers.last).first_or_create!
5.times do
  Match.where(receiver: Ask.all.sample, provider: Offer.all.sample).first_or_create!
end

# organization
org = Organization.where(name: "Diaper Bank").first_or_create!
# community_resources
CommunityResource.where(name: "this is diapers for you", description: "first come first serve", organization: org).first_or_create!
5.times do
  org = Organization.create!(name: Faker::Company.name)
  CommunityResource.create!(name: Faker::Lorem.words(number: (2..5).to_a.sample).join(" "), description: Faker::Lorem.sentences(number: (1..5).to_a.sample).join(" "), organization: org)
end

# announcements
Announcement.where(name: "Lansing urgent care are sharing free face masks", description: "Announcement announcement urgent care! Free masks!").first_or_create!
5.times do
  Announcement.create!(name: Faker::Lorem.words(number: (2..5).to_a.sample).join(" "), description: Faker::Lorem.sentences(number: (1..6).to_a.sample).join(" "))
end

# communication_logs
log_1 = CommunicationLog.where(
    subject: "hello from LAMA",
    body: "we'd love to talk with you!",
    person: person,
    delivery_method: non_autoemail_contact_methods.sample,
    delivery_status: "completed"
).first_or_create!(sent_at: Time.now - 3.days) # wow!!!

log_2 = CommunicationLog.where(
    subject: "we'd like your feedback!",
    body: "how was your experience?",
    delivery_method: ContactMethod.autoemail(true).last,
    delivery_status: "completed"
).first_or_create!(sent_at: Time.now - 1.day)

# offers for person
Category.all.pluck(:name).sample(1).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.all.sample).create!
  offer.tag_list << tag
  offer.save!
end

5.times do
  Team.where(name: Faker::Job.field).first_or_create!(organization: Organization.all.sample)
end

15.times do
  Position.where(team: Team.all.sample, organization: Organization.all.sample, person: Person.all.sample, name: Faker::Job.position).first_or_create!
end

10.times do
  Donation.where(person: Person.all.sample, value: rand(1000).to_f, channel: Donation::CHANNELS.sample).first_or_create!
end

6.times do
  SoftwareFeedback.where(created_by: User.all.sample,
                         name: Faker::Lorem.sentence,
                         page_url: "localhost:3000/#{SoftwareFeedback::MODULE_NAMES.sample.downcase.parameterize.underscore}",
                         module_name: SoftwareFeedback::MODULE_NAMES.sample,
                         feedback_type: SoftwareFeedback::FEEDBACK_TYPES.sample,
                         urgency: SoftwareFeedback::URGENCIES.sample).first_or_create!
end

Match.all.sample((Match.count * 50)/100).each do |match|
  Feedback.create!(match: match,
                   is_from_receiver: [true, false].sample,
                   completed: [true, false].sample,
                   description: Faker::Lorem.sentences(number: 3).join(" "),
                   quality: (1..5).to_a.sample)
end

4.times do
  SharedAccount.where(name: ["ourmutualaidgroup@gmail.com", "Facebook", "SuchandSuch Bank", "PO Box"].sample,
                      account_url: Faker::Internet.url,
                      username: Faker::Internet.username,
                      password_hint: Faker::Lorem.words(number: 5).to_sentence,
                      notes: Faker::Lorem.sentences(number: 1).join(" ")).first_or_create!
end

Person.where.not(email: nil).sample(7).each do |person|
  User.where(email: person.email).first_or_create!(confirmed_at: person.created_at, password: person.name.parameterize)
end

# autoemail logs per Listing
Listing.all.each do |listing|
  delivery_method = ContactMethod.autoemail(true).sample
  listing_type = listing.type
  if listing_type == "Ask"
    match = listing.matches_as_receiver.first
  elsif listing_type == "Offer"
    match = listing.matches_as_provider.first
  end
  CommunicationLog.create!(person: listing.person,
                           match: match,
                           created_by: delivery_method&.name.include?("autoemail") ? User.first : User.all.sample,
                           outbound: [true, false].sample,
                           sent_at: listing.created_at,
                           delivery_method: delivery_method,
                           needs_follow_up: [true, false].sample,
                           delivery_status: CommunicationLog::DELIVERY_STATUSES.sample,
                           subject: Faker::Lorem.words(number: (2..5).to_a.sample).join(" "),
                           body: Faker::Lorem.sentences(number: (5..15).to_a.sample).join(" "))
end
# 70% get random manual logs
Listing.all.sample((Listing.count * 70)/100) do |listing|
  delivery_method = non_autoemail_contact_methods.sample
  delivery_status = (CommunicationLog::DELIVERY_STATUSES - [CommunicationLog::DEFAULT_DELIVERY_STATUS]).sample
  CommunicationLog.create!(person: listing.person,
                           match: listing.matches.first,
                           created_by: User.all.sample,
                           outbound: [true, false].sample,
                           sent_at: Faker::Time.between(from: listing.created_at, to: DateTime.now),
                           delivery_method: delivery_method,
                           needs_follow_up: [true, false].sample,
                           delivery_status: delivery_status,
                           subject: Faker::Lorem.words(number: (2..5).to_a.sample).join(" "),
                           body: Faker::Lorem.sentences(number: (5..15).to_a.sample).join(" "))
end

# submissions
Listing.all.each do |listing|
  submission = Submission.where(person: listing.person, service_area: listing.service_area, form_name: "#{listing.type}_form", privacy_level_requested: Submission::PRIVACY_LEVELS.sample,
                   body: listing.to_json).create!
  listing.submission = submission
  listing.save!
end

# custom_form_questions (separate importer)
# submission_responses (separate importer)

puts "completed dev_seeds.rb"
