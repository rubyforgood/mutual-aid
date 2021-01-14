require 'rails_helper'

RSpec.describe ClaimContribution do
  before do
    allow(MatchContribution).to receive(:run!)
    allow(EmailPeer).to receive(:run!)
  end

  let(:contribution) { create(:listing) }
  let(:user) { create(:user)}
  let(:peer_alias) { 'alias' }
  let(:email) { 'user_email@example.com' }

  subject(:interaction) { ClaimContribution.run!(
    contribution: contribution.id,
    current_user: user,
    email: email,
    peer_alias: peer_alias,
    message: 'message',
  )}

  it "matches contribution and sends an email to peer", :aggregate_failures do
    allow_any_instance_of(ClaimContribution).to receive(:add_person_details)

    interaction

    expect(MatchContribution).to have_received(:run!)
    expect(EmailPeer).to have_received(:run!)
  end

  context "when current user has no person record" do
    it "creates a person" do
      interaction

      expect(user.reload.person).to have_attributes(name: peer_alias,
                                                    email: email,
                                                    preferred_contact_method: ContactMethod.email,
                                                    user: user)
    end
  end

  context "when current has a person" do
    let(:user) { create(:user, :with_person)}

    it "updates the person email address" do
      interaction

      expect(user.reload.person).to have_attributes(email: email, user: user)
    end
  end
end
