require 'rails_helper'

RSpec.describe Ask do
  describe 'matched' do
    it 'returns matched asks' do
      unmatched_ask = create(:ask)
      match = create(:match, :with_ask_and_offer)
      matched_ask = match.receiver

      expect(Ask.matched).to eq([matched_ask])
    end
  end

  describe 'matchable' do
    it 'returns matchable asks' do
      unmatched_ask = create(:ask)
      match = create(:match, :with_ask_and_offer)
      matched_ask = match.receiver

      expect(Ask.matchable).to eq([unmatched_ask])
    end
  end
end
