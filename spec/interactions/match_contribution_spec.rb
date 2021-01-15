require 'rails_helper'

RSpec.describe MatchContribution do
  let(:person) { create(:person) }

  before do
    MatchContribution.run!(contribution: contribution, match_with: person)
  end

  let(:last_match) { Match.last }

  context "when contribution is an ask" do
    let(:contribution) { create(:ask) }
    let(:last_offer) { Offer.last }

    it "offer is created & match is created", :aggregate_failures do
      expect(last_match).to have_attributes(receiver: contribution, provider: last_offer, status: 'match_confirmed')
      expect(last_offer).to have_attributes(person: person, service_area: contribution.service_area)
      expect(contribution.matched?).to be true
    end
  end

  context "when contribution is an offer" do
    let(:contribution) { create(:offer) }
    let(:last_ask) { Ask.last }

    it "ask is created & match is created", :aggregate_failures do
      expect(last_match).to have_attributes(receiver: last_ask, provider: contribution, status: 'match_confirmed')
      expect(last_ask).to have_attributes(person: person, service_area: contribution.service_area)
      expect(contribution.matched?).to be true
    end
  end
end
