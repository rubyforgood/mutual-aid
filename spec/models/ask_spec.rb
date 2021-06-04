require 'rails_helper'

RSpec.describe Ask do
  describe 'matched' do
    it 'returns matched asks' do
      unmatched_ask = create(:ask)
      match = create(:match, :with_ask_and_offer)
      matched_ask = match.receiver

      expect(Ask.matched).to include matched_ask
      expect(Ask.matched).to_not include unmatched_ask
    end
  end

  describe 'matchable' do
    it 'returns matchable asks' do
      unmatched_ask = create(:ask)
      match = create(:match, :with_ask_and_offer)
      matched_ask = match.receiver

      expect(Ask.matchable).to include unmatched_ask
      expect(Ask.matchable).to_not include matched_ask
    end
  end
end
