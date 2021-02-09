require 'rails_helper'

RSpec.describe ClaimContribution do
  before do
    allow(MatchContribution).to receive(:run!)
    allow(EmailPeer).to receive(:run!)
  end

  let(:contribution) { create(:listing) }
  let(:user) { create(:user, :with_person, email: 'user_email@example.com') }

  before do
    ClaimContribution.run!(
      contribution: contribution.id,
      current_user: user,
      peer_alias: 'alias',
      message: 'message',
    )
  end

  it "matches contribution and sends an email to peer", :aggregate_failures do
    expect(MatchContribution).to have_received(:run!)
    expect(EmailPeer).to have_received(:run!)
  end

  context "when current user has no person record" do
    let(:user) { create(:user, email: 'user_email@example.com', person: nil) }

    it "creates a person" do
      expect(user.reload.person).to have_attributes(
        user: user,
        email: user.email,
        name: 'alias',
        preferred_contact_method: ContactMethod.email,
      )
    end
  end
end
