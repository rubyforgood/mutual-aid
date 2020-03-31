require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:listing) { build(:offer) }

  describe 'tagging' do
    example 'smoke test' do
      listing.tags = ['grocery shopping', 'childcare']
      listing.tags << 'cash'
      listing.save

      expect(Listing.with_any_tags('cash')).to match_array([listing])
    end
  end

end
