user = User.where(email: "mutualaidtesting@example.com").first_or_create!(password: "testing123")
user.confirmed_at = Time.now
user.save!

Category::DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent).first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name).first_or_create!
  end
end

puts "completed seeds.rb"