require 'rails_helper'

RSpec.describe ClaimContribution do
  let(:contribution) { create(:listing) }
  let(:user) { create(:user, :with_person, email: 'user_email@example.com') }

  let(:claim_contribution) do
    ClaimContribution.run!(
      contribution: contribution.id,
      current_user: user,
      organization: build(:organization),
      peer_alias: 'alias',
      message: 'message'
    )
  end

  it "matches the contribution" do
    expect { claim_contribution }.to change(Match, :count).by(1)
    expect(contribution.matches.count).to be(1)
  end

  it "sends an email to the peer" do
    expect { claim_contribution }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end

  context "when current user has no person record" do
    let(:user) { create(:user, email: 'user_email@example.com', person: nil) }

    it "creates a person" do
      claim_contribution

      expect(user.reload.person).to have_attributes(
        user: user,
        email: user.email,
        name: 'alias',
        preferred_contact_method: ContactMethod.email
      )
    end
  end
end
