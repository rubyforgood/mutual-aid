require 'rails_helper'

RSpec.describe '/contributions/:contribution_id/claims', type: :request do
  before { sign_in create(:user) }

  describe 'GET /new' do
    it 'renders a successful response' do
      contribution = create(:listing)

      get new_contribution_claim_url(contribution)

      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) do
      {
        claim: {
          peer_alias: 'alias',
          preferred_contact_method_id: 1,
          preferred_contact_info: 'info',
          message: 'message'
        }
      }
    end

    before do
      allow(AddPersonDetailsFromClaimParams).to receive(:run!)
      allow(CreateMatchForContribution).to receive(:run!)
      allow(EmailPeer).to receive(:run!)
    end

    it 'creates a new Person and Match and sends an email to peer', :aggregate_failures do
      contribution = create(:listing)

      post contribution_claims_url(contribution), params: valid_attributes

      expect(AddPersonDetailsFromClaimParams).to have_received(:run!)
      expect(CreateMatchForContribution).to have_received(:run!)
      expect(EmailPeer).to have_received(:run!)
    end
  end
end
