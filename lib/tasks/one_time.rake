# frozen_string_literal: true

require_relative './support/listing_converter'

namespace :one_time do
  desc 'split listings with multiple tags into one listing for each tag'
  task split_listings: :environment do
    converter = ListingConverter.new

    relevant_listings = Listing.joins(:taggings).group('listings.id').having('count(taggable_id) > 1')
    puts "Processing #{relevant_listings.count.keys.size} listings"

    relevant_listings.find_each do |listing|
      puts "#, #{listing.id}, #{listing.tag_list}"
      new_listings = converter.convert listing

      puts "-, #{listing.id}, #{listing.reload.tag_list}"
      new_listings.each{ |new_listing| puts "+, #{new_listing.id}, #{new_listing.tag_list}" }
    end
  end

  # FIXME: remove this after existing installations are upgraded
  desc 'give existing users admin privileges'
  task make_users_admins: :environment do
    User.connection.update("update users set role = 'admin' where role = 'unset'")
  end
end
