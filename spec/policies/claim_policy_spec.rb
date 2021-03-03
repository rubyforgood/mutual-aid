require 'spec_helper'

RSpec.describe ClaimPolicy do
  let(:system_settings) { double :system_setting }
  let(:context) { Context.new user: user, system_settings: system_settings }

  subject { ClaimPolicy.new(context, :claim) }

  context 'with a guest user' do
    let(:user) { nil }

    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'with an authenticated user' do
    let(:user) { double :user }

    context 'in dispatch mode' do
      before { allow(system_settings).to receive(:peer_to_peer?).and_return(false) }

      it { is_expected.to forbid_new_and_create_actions }
    end

    context 'in peer to peer mode' do
      before { allow(system_settings).to receive(:peer_to_peer?).and_return(true) }

      it { is_expected.to permit_new_and_create_actions }
    end
  end
end
