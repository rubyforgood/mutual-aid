require 'rails_helper'

RSpec.describe ClaimContribution do
  before do
    allow(MatchContribution).to receive(:run!)
    allow(EmailPeer).to receive(:run!)
  end

  let(:claim_params) do
    {
      peer_alias: 'alias',
      email: 'user_email@example.com',
      message: 'message'
    }
  end

  it "matches contribution and sends an email to peer", :aggregate_failures do
    contribution = create(:listing)
    allow_any_instance_of(ClaimContribution).to receive(:add_person_details)

    ClaimContribution.run!(
      contribution: contribution.id,
      claim_params: claim_params,
      current_user: build(:user)
    )

    expect(MatchContribution).to have_received(:run!)
    expect(EmailPeer).to have_received(:run!)
  end

  it "creates a person if current user has no person record" do
    contribution = create(:listing)
    user = create(:user)

    ClaimContribution.run!(
      contribution: contribution.id,
      claim_params: claim_params,
      current_user: user
    )

    expect(user.reload.person).to have_attributes(name: claim_params[:peer_alias],
                                                  email: claim_params[:email],
                                                  preferred_contact_method: ContactMethod.email,
                                                  user: user)
  end

  it "updates the person email address" do
    contribution = create(:listing)
    user = create(:user, :with_person)

    ClaimContribution.run!(
      contribution: contribution.id,
      claim_params: claim_params,
      current_user: user
    )

    expect(user.reload.person).to have_attributes(email: claim_params[:email], user: user)
  end
end
