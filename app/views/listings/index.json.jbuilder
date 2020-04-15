json.listings do
    json.array! @listings, partial: "listings/listing", as: :listing
end
json.urls do
    json.new_listing new_listing_path
end