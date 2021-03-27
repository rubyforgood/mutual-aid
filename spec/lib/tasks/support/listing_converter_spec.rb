require 'rails_helper'
require 'tasks/support/listing_converter'

RSpec.describe ListingConverter do
  let(:converter) { ListingConverter.new }
  let(:convert)   { converter.convert listing }

  before { Category.destroy_all } # from seeds

  context 'without sub-categories' do
    let(:tags)        { %w[cash errands housing] }
    let!(:categories) { tags.map{ |name| create :category, name: name }}
    let(:listing)     { create :listing, tag_list: tags }

    it 'removes all but one tag from the original listing' do
      convert
      expect(listing.reload.tag_list.size).to be 1
      expect(tags).to include listing.tag_list.first
    end

    it 'creates a listing for each extraneous tag' do
      convert
      expect(Listing.count).to be 3
    end

    it 'sets the tag on each new listing' do
      new_listings = convert
      expect(new_listings.map(&:tag_list).flatten).to match_array(tags - listing.reload.tag_list)
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
      let!(:provider_match) { create(:match, :with_ask_and_offer, provider: listing) }
      let!(:receiver_match) { create(:match, :with_ask_and_offer, receiver: listing) }

      it 'keeps matches only on the original listing' do
        new_listing = convert.last
        expect(listing.matches_as_provider).to_not be_empty
        expect(listing.matches_as_receiver).to_not be_empty
        expect(new_listing.matches_as_provider).to be_empty
        expect(new_listing.matches_as_receiver).to be_empty
      end
    end
  end

  context 'with only a parent- and sub-category' do
    let!(:parent)      { create :category, name: 'food' }
    let!(:child)       { create :category, name: 'meals', parent: parent }
    let!(:listing)     { create :listing, tag_list: %w[food meals] }

    it 'does not create any new listings' do
      expect{ convert }.to_not change(Listing, :count)
    end

    it 'leaves the listing tags unchanged' do
      convert
      expect(listing.tag_list).to match_array %w[food meals]
    end
  end

  context 'with a mix of single tags and and nested categories' do
    let!(:unrelated)   { create :category, name: 'cash' }
    let!(:parent)      { create :category, name: 'food' }
    let!(:child)       { create :category, name: 'meals',     parent: parent }
    let!(:other_child) { create :category, name: 'groceries', parent: parent }
    let!(:grand_child) { create :category, name: 'delivery',  parent: child }

    let!(:listing)     { create :listing, tag_list: %w[food meals cash groceries delivery] }

    it 'leaves the listing with one of the tag sets' do
      convert
      expect(listing.tag_list).to match_array %w[food meals delivery]
    end

    it 'creates listing for the remaining tag sets' do
      expect(convert.map(&:tag_list)).to match_array [
        %w[cash],
        %w[food groceries],
      ]
    end
  end

  describe 'TagSplitter' do
    let(:splitter) { ListingConverter::TagSplitter.new(lineages) }
    let(:lineages) {{
      'grandchild'  => %w[parent child grandchild],
      'child'       => %w[parent child],
      'other_child' => %w[parent other_child],
      'parent'      => %w[parent],
      'orphan'      => %w[orphan],
    }}

    subject { splitter.split tag_list }

    context 'single tag' do
      let(:tag_list) { %w[orphan] }
      it { is_expected.to contain_exactly %w[orphan] }
    end

    context 'unrelated tags' do
      let(:tag_list) { %w[parent orphan] }
      it { is_expected.to contain_exactly %w[parent], %w[orphan] }
    end

    context 'parent, child' do
      let(:tag_list) { %w[parent child] }
      it { is_expected.to contain_exactly %w[parent child] }
    end

    context 'when tagged out of order' do
      let(:tag_list) { %w[child parent] }
      it { is_expected.to contain_exactly %w[parent child] }
    end

    context 'parent, orphan, child' do
      let(:tag_list) { %w[parent child orphan] }
      it { is_expected.to contain_exactly %w[parent child], %w[orphan] }
    end

    context 'parent, child, other_child' do
      let(:tag_list) { %w[parent child other_child] }
      it { is_expected.to contain_exactly %w[parent child], %w[parent other_child] }
    end

    context 'parent, child, other_child, grandchild' do
      let(:tag_list) { %w[parent child other_child grandchild] }
      it { is_expected.to contain_exactly %w[parent child grandchild], %w[parent other_child] }
    end

    context 'parent, child, other_child, grandchild' do
      let(:tag_list) { %w[parent child other_child grandchild] }
      it { is_expected.to contain_exactly %w[parent child grandchild], %w[parent other_child] }
    end
  end
end
