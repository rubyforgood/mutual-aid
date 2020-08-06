class ListingConverter
  attr_reader :listing

  def initialize listing
    @listing = listing
  end

  def convert
    Listing.transaction do
      first_tag, *tags_to_move = listing.tag_list
      tags_to_move.each do |tag|
        new_listing = listing.dup
        new_listing.update!(
          tag_list: [tag],
          created_at: listing.created_at,
        )
      end
      listing.tag_list = [first_tag]
      listing.save!
    end
  end
end
