require 'spec_helper'

RSpec.describe NavBarPolicy do
  let(:peer_to_peer?) { false }
  let(:context) { Context.new user: user, system_settings: instance_double('SystemSetting', peer_to_peer?: peer_to_peer?) }
  let(:policy)  { NavBarPolicy.new context, :nav_bar }

  describe 'visible_buttons' do
    subject { policy.visible_buttons }

    context 'guest' do
      let(:user) { nil }

      it { is_expected.to match_array %w[Login] }

      context 'in peer_to_peer mode' do
        let(:peer_to_peer?) { true }
        it { is_expected.to match_array %w[Contributions Login] }
      end
    end

    context 'neighbor' do
      let(:user) { instance_double 'User', admin_role?: false, sys_admin_role?: false }

      it { is_expected.to match_array %w[Feedback Logout]  }

      context 'in peer_to_peer mode' do
        let(:peer_to_peer?) { true }
        it { is_expected.to match_array %w[Contributions Feedback Logout] }
      end
    end

    context 'admin' do
      let(:user) { instance_double 'User', admin_role?: true, sys_admin_role?: false }
      it { is_expected.to match_array %w[Contributions Matches Admin Feedback Logout]  }
    end

    context 'sys_admin' do
      let(:user) { instance_double 'User', admin_role?: false, sys_admin_role?: true }
      it { is_expected.to match_array %w[Contributions Matches Admin Feedback Logout]  }
    end
  end
end
