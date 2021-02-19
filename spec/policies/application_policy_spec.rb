require 'spec_helper'

RSpec.describe ApplicationPolicy do
  let(:system_settings) { instance_double 'SystemSetting' }
  let(:user)            { instance_double 'User' }
  let(:record)          { double :record }
  let(:context)         { Context.new user: user, system_settings: system_settings }
  let(:policy)          { ApplicationPolicy.new context, record }

  describe 'initialization' do
    it 'accepts Context and extracts its contents' do
      expect(policy.acting_user).to be user
      expect(policy.system_settings).to be system_settings
    end

    it 'also supports User instead of context' do
      policy = ApplicationPolicy.new user, record
      expect(policy.acting_user).to be user
      expect(policy.system_settings).to be nil
    end
  end

  describe 'default authorizations' do
    it 'forbids all actions' do
      expect(policy).to forbid_actions %i[show new create edit update destroy]
    end

    it 'fails if index action is checked' do
      expect { policy.index? }.to raise_error StandardError
    end
  end

  describe 'hiding admin privileges' do
    let(:context) { Context.new user: user, admin_param: admin_param }

    subject { policy.admin? }

    context 'for a user without admin privileges' do
      let(:user) { instance_double 'User', admin_role?: false }

      context 'without ?admin override' do
        let(:admin_param) { nil }
        it { is_expected.to be false }
      end

      context 'with ?admin=false' do
        let(:admin_param) { 'false' }
        it { is_expected.to be false }
      end
    end

    context 'for a user with admin privileges' do
      let(:user) { instance_double 'User', admin_role?: true }

      context 'without ?admin override' do
        let(:admin_param) { nil }
        it { is_expected.to be true }
      end

      context 'with ?admin=false' do
        let(:admin_param) { 'false' }
        it { is_expected.to be false }
      end
    end

    context 'for a user with sysadmin privileges' do
      let(:user) { instance_double 'User', sys_admin_role?: true }

      subject { policy.sys_admin? }

      context 'without ?admin override' do
        let(:admin_param) { nil }
        it { is_expected.to be true }
      end

      context 'with ?admin=false' do
        let(:admin_param) { 'false' }
        it { is_expected.to be false }
      end
    end
  end
end
