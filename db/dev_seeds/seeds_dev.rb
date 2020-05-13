# to run this file manually run $ rails runner -e development db/seeds_dev.rb

require 'faker'

email_contact_method = ContactMethod.where(ContactMethod.arel_table[:name].matches('email')).first || ContactMethod.create!(name: "Email", field: "email")
phone_contact_method = ContactMethod.where(ContactMethod.arel_table[:name].matches('phone')).first || ContactMethod.create!(name: "Text", field: "phone")

# people
person = Person.where(name: Faker::Name.name, preferred_contact_method: email_contact_method, email: Faker::Internet.email).first_or_create!
person_2 = Person.where(preferred_contact_method: phone_contact_method, phone: Faker::PhoneNumber.phone_number).first_or_create!
# asks for person
Category.all.pluck(:name).sample(4).each do |tag|
  ask = Ask.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  ask.tag_list << tag
  ask.save!
end
# offers for person
Category.all.pluck(:name).sample(1).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tag_list << tag
  offer.save!
end
# offers for person_2
Category.all.pluck(:name).sample(4).each do |tag|
  offer = Offer.where(person: person_2, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tag_list << tag
  offer.save!
end
# matches
match_1 = Match.where(receiver: person, provider: person_2.offers.last).first_or_create!
# organization
org = Organization.where(name: "Diaper Bank").first_or_create!
# community_resources
CommunityResource.where(name: "this is diapers for you", description: "first come first serve", organization: org).first_or_create!
# announcements
Announcement.where(name: "Lansing urgent care are sharing free face masks", description: "Announcement announcement urgent care! Free masks!").first_or_create!
# communication_logs
log_1 = CommunicationLog.where(
    subject: "hello from LAMA",
    body: "we'd love to talk with you!",
    person: person,
    delivery_channel: "email",
    delivery_status: "completed"
).first_or_create!(sent_at: Time.now - 3.days) # wow!!!

log_2 = CommunicationLog.where(
    subject: "we'd like your feedback!",
    body: "how was your experience?",
    delivery_channel: "autoemail",
    delivery_status: "completed"
).first_or_create!(sent_at: Time.now - 1.day)


# submissions
Ask.all.sample(2).each do |ask|
  Submission.where(person: ask.person, service_area: ask.service_area, form_name: "ask_form", privacy_level_requested: "none", body: ask.to_json).create! # TODO - make this idempotent
end
Offer.all.sample(2).each do |offer|
  Submission.where(person: offer.person, service_area: offer.service_area, form_name: "ask_form", privacy_level_requested: "none", body: offer.to_json).create! # TODO - make this idempotent
end

# offers for person
Category.all.pluck(:name).sample(1).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tag_list << tag
  offer.save!
end

# donations
# custom_form_questions
# feedbacks
# locations
# service_areas
# shared_accounts
puts "completed seeds_dev.rb"
