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

    it 'claims the contribution' do
      allow(ClaimContribution).to receive(:run!)

      post contribution_claims_url(1), params: valid_attributes

      expect(ClaimContribution).to have_received(:run!)
    end
  end
end
