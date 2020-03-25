json.extract! listing, :id, :title, :description, :type, :created_at, :updated_at
json.url listing_url(listing, format: :json)
