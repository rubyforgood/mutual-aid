require 'spec_helper'

RSpec.describe ContributionPolicy do
  let(:context) { Context.new user: user }
  let(:contribution) { double :contribution }

  subject { ContributionPolicy.new context, contribution }

  context 'guest user' do
    let(:user) { nil }

    it { is_expected.to permit_actions %i[show] }
    it { is_expected.to forbid_actions %i[new edit update destroy] }
  end

  context 'authenticated user' do
    let(:user) { FactoryBot.build :user, :dispatcher }

    it { is_expected.to permit_actions %i[show] }
    it { is_expected.to forbid_actions %i[new edit update destroy] }
  end

  context 'admin user' do
    let(:user) { FactoryBot.build :user, :admin }

    it { is_expected.to permit_actions %i[show edit update destroy] }
  end
end
