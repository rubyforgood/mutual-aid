# to run this file manually run $ rails -r -e development db/seeds_dev.rb 

# people
person = Person.where(preferred_contact_method: "email", email: "personsemail@example.com(opens in new tab)").first_or_create!
person_2 = Person.where(preferred_contact_method: "phone", phone: "123-123-1234").first_or_create!
# asks for person
Category::DEFAULT_TAGS.sample(4).each do |tag|
  ask = Ask.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  ask.tags << tag
  ask.save!
end
# offers for person
Category::DEFAULT_TAGS.sample(1).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tags << tag
  offer.save!
end
# offers for person_2
Category::DEFAULT_TAGS.sample(4).each do |tag|
  offer = Offer.where(person: person_2, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tags << tag
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
  submission = Submission.where(
    person: ask.person, service_area: ask.service_area, form_name: "ask_form", privacy_level_requested: "none", body: ask.to_json).create! # TODO - make this idempotent
  ask.tags << tag
  ask.save!
end
# offers for person
Category::DEFAULT_TAGS.sample(1).each do |tag|
  offer = Offer.where(person: person, service_area: ServiceArea.take).create! # TODO - make this idempotent
  offer.tags << tag
  offer.save!
end
# donations
# custom_form_questions
# feedbacks
# locations
# service_areas
# shared_accounts
puts "completed seeds_dev.rb"
