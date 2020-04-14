json.extract! listing, :id, :name, :type
json.created_at "#{listing.created_at.to_formatted_s(:long)} #{listing.created_at.zone}"
json.updated_at "#{listing.updated_at.to_formatted_s(:long)} #{listing.updated_at.zone}"
json.url listing_url(listing, format: :json)
