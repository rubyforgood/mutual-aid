require 'rails_helper'

# FIXME: remove or consolidate this block once #834 is resolved
RSpec.configure do
  Pundit::Matchers.configure do |config|
    config.user_alias = :acting_user
  end
end

RSpec.describe CommunityResourcePolicy do
  let(:context) { Context.new user: user }
  let(:community_resource) { double :community_resource }

  let(:approved_community_resource) { create :community_resource, is_approved: true }
  let(:pending_community_resource)  { create :community_resource, is_approved: false }
  let(:create_community_resources)  { [approved_community_resource, pending_community_resource] }

  let(:policy_scope) { CommunityResourcePolicy::Scope.new(context, CommunityResource.all).resolve }

  subject { CommunityResourcePolicy.new context, community_resource }

  context 'guest user' do
    let(:user) { nil }

    it { is_expected.to permit_actions %i[show new create] }
    it { is_expected.to forbid_actions %i[edit update destroy] }
    it { is_expected.to forbid_mass_assignment_of :is_approved }

    it 'is only shown approved community_resources' do
      create_community_resources
      expect(policy_scope).to match [approved_community_resource]
    end
  end

  context 'authenticated user' do
    let(:user) { build :user }

    it { is_expected.to permit_actions %i[show new create] }
    it { is_expected.to forbid_actions %i[edit update destroy] }
    it { is_expected.to forbid_mass_assignment_of :is_approved }

    it 'is only shown approved community_resources' do
      create_community_resources
      expect(policy_scope).to match [approved_community_resource]
    end
  end

  context 'admin user' do
    let(:user) { build :user, :admin }

    it { is_expected.to permit_actions %i[show new create edit update destroy] }
    it { is_expected.to permit_mass_assignment_of :is_approved }

    it 'is shown all community_resources' do
      create_community_resources
      expect(policy_scope).to match [approved_community_resource, pending_community_resource]
    end
  end
end
