user = User.where(email: "#{ENV["SYSTEM_EMAIL"]}").first_or_create!(password: "#{ENV["SYSTEM_PASSWORD"]}")
user.confirmed_at = Time.now
user.save!

Category::DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent).first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name).first_or_create!
  end
end

puts "completed seeds.rb"