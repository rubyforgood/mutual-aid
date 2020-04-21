user = User.where(email: "mutualaidtesting@testing.com").first_or_create!(password: "testing123")

Category::DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent, created_by: "System").first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name, created_by: "System").first_or_create!
  end
end

puts "completed seeds.rb"