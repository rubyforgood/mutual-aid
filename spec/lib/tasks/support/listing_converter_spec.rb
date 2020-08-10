require 'rails_helper'
require 'tasks/support/listing_converter'

RSpec.describe ListingConverter do
  let(:converter) { ListingConverter.new listing }
  let(:convert)   { converter.convert }

  describe 'does not process listing with one tag' do
    let!(:listing) { create :listing, tag_list: %w[errands] }

    it 'does not add any new listings' do
      expect{ convert }.to_not change(Listing, :count)
    end

    it 'does not change the listing' do
      convert
      expect(listing.changes).to be_empty
    end
  end

  context 'for a listing with multiple tags' do
    let(:listing) { create :listing, tag_list: %w[cash errands housing] }

    it 'removes all but the first tag from the original listing' do
      convert
      expect(listing.reload.tag_list).to eq %w[cash]
    end

    it 'creates a listing for each extraneous tag' do
      convert
      expect(Listing.count).to be 3
    end

    it 'sets the tag on each new listings' do
      new_listings = convert
      expect(new_listings.map(&:tag_list)).to contain_exactly %w[errands], %w[housing]
    end

    it 'copies attributes from original listing except id, tag_list, and updated_at' do
      original = listing.attributes.to_a
      new_listing = convert.last
      copied = new_listing.attributes.to_a
      expect((copied - original).to_h.keys).to match_array %w[id tag_list updated_at]
    end

    it 'keeps the association with a submission' do
      listing.update!(submission: create(:submission))
      new_listing = convert.last
      expect(new_listing.submission).to be_present
      expect(new_listing.submission).to eq listing.submission
    end

    describe 'with matches' do
      let(:listing) do
        listing = create(:listing, tag_list: %w[cash errands housing])
        create(:match, :with_ask_and_offer, provider: listing)
        create(:match, :with_ask_and_offer, receiver: listing)
        listing
      end

      it 'keeps matches only on the original listing' do
        new_listing = convert.last
        expect(listing.matches_as_provider).to_not be_empty
        expect(listing.matches_as_receiver).to_not be_empty
        expect(new_listing.matches_as_provider).to be_empty
        expect(new_listing.matches_as_receiver).to be_empty
      end
    end

    pending 'when tags include sub-categories'
  end
end
