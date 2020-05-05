person = Person.first_or_create!(preferred_contact_method: "email", email: "personsemail@example.com")
Category::DEFAULT_TAGS.sample(4).each do |tag|
  Ask.where(person: person).create! # TODO - make this idempotent
end

Category::DEFAULT_TAGS.sample(4).each do |tag|
  Offer.where(person: person).create! # TODO - make this idempotent
end

puts "completed seeds_devt.rb"