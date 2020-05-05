user = User.where(email: "#{ENV["SYSTEM_EMAIL"]}").first_or_create!(password: "#{ENV["SYSTEM_PASSWORD"]}")
user.confirmed_at = Time.now # we currently have Devise :confirmable strategy turned on, so all new users need their email confirmed
user.save!

Category::DEFAULT_TAGS.each do |tag_name_parent, subtag_name|
  parent = Category.where(name: tag_name_parent).first_or_create!
  if subtag_name.present?
    Category.where(parent: parent, name: subtag_name).first_or_create!
  end
end

host_organization = Organization.where(is_instance_owner: true).first_or_create!(name: "[CHANGEME] Default Mutual Aid Group")
default_system_settings = SystemSetting.first_or_create!

Position.where(position_type: Position::ASK_FORM_CONTACT_TITLE, organization: host_organization).first_or_create!
Position.where(position_type: Position::OFFER_FORM_CONTACT_TITLE, organization: host_organization).first_or_create!
Position.where(position_type: Position::COMMUNITY_RESOURCES_CONTACT_TITLE, organization: host_organization).first_or_create!

puts "completed seeds.rb"