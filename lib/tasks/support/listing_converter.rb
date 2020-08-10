class ListingConverter
  attr_reader :listing

  def initialize listing
    @listing = listing
  end

  def convert
    Listing.transaction do
      first_tag, *tags_to_move = listing.tag_list

      listing.tag_list = [first_tag]
      listing.save!

      tags_to_move.map do |tag|
        listing.dup.tap do |new_listing|
          new_listing.update!(
            tag_list: [tag],
            created_at: listing.created_at,
          )
        end
      end
    end
  end
end
