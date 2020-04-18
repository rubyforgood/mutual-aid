require 'rails_helper'

RSpec.describe ListingForm do
  describe '.all_tags' do
    let!(:listing) { create :listing, tags: ['a custom tag'] }

    let(:default_tags) { ListingForm::DEFAULT_TAGS }

    subject(:all_tags) { ListingForm.all_tags }


    it 'includes both default and custom system_tags' do
      expect(all_tags.size).to eq(default_tags.size + 1)
    end

    it 'appends custom system_tags to the bottom' do
      expect(all_tags.last).to eq('a custom tag')
    end

    it 'does not duplicate system_tags from the default list' do
      listing.tags << default_tags.last
      listing.save

      expect(all_tags.size).to eq(default_tags.size + 1)
    end
  end
end
