user = User.where(email: "mutualaidtesting@testing.com").first_or_create!(password: "testing123")

SystemTag::DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Tag.where(name: tag_name_parent, created_by: "System").first_or_create!
  if subtag_name.present?
    Tag.where(parent: parent, name: subtag_name, created_by: "System").first_or_create!
  end
end

puts "completed seeds.rb"