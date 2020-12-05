require 'rails_helper'

RSpec.describe ClaimContribution do
  before do
    allow(AddPersonDetailsFromClaimParams).to receive(:run!)
    allow(MatchContribution).to receive(:run!)
    allow(EmailPeer).to receive(:run!)
  end

  let(:claim_params) do
    {
      peer_alias: 'alias',
      preferred_contact_method_id: 1,
      preferred_contact_info: 'info',
      message: 'message'
    }
  end

  it "creates/updates a Person, matches contribution and sends an email to peer" do
    contribution = create(:listing)

    ClaimContribution.run!(
      contribution: contribution.id,
      claim_params: claim_params,
      current_user: build(:user)
    )

    expect(AddPersonDetailsFromClaimParams).to have_received(:run!)
    expect(MatchContribution).to have_received(:run!)
    expect(EmailPeer).to have_received(:run!)
  end
end
