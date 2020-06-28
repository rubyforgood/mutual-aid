require 'rails_helper'

RSpec.describe Offer do
  describe 'matched' do
    it 'returns matched offers' do
      unmatched_offer = create(:offer)
      match = create(:match, :with_ask_and_offer)
      matched_offer = match.provider

      expect(Offer.matched).to eq([matched_offer])
    end
  end

  describe 'matchable' do
    it 'returns matchable offers' do
      unmatched_offer = create(:offer)
      match = create(:match, :with_ask_and_offer)
      matched_offer = match.provider

      expect(Offer.matchable).to eq([unmatched_offer])
    end
  end
end
