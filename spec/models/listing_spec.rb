require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:listing) { build(:offer, person: create(:person)) }

  describe 'tagging' do
    example 'smoke test' do
      listing.tag_list.add('grocery shopping', 'childcare')
      listing.tag_list.add('cash')
      listing.save!

      expect(Listing.tagged_with('cash')).to match_array([listing])
    end

    example 'name method' do
      listing.tag_list.add('grocery shopping', 'childcare')
      listing.save!

      expect(listing.name).to eq("Offer: grocery shopping, childcare")
    end
  end

  describe 'properties' do
    example 'with email' do
      listing = build(:offer, person: build(:person, email: 'user@email.com'))

      expect(listing.has_email?).to eq(true)
    end

    example 'without email' do
      listing = build(:offer, person: build(:person, email: nil))

      expect(listing.has_email?).to eq(false)
    end
  end
end
