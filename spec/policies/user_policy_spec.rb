require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(current_user, target_user) }

  let(:resolved_scope) {
    UserPolicy::Scope.new(current_user, User.all).resolve
  }

  context "given a normal signed-in user, targeting themselves" do
    let(:current_user) { create(:user) }
    let(:target_user)  { current_user }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given a normal signed-in user and a different User" do
    let(:current_user) { create(:user) }
    let(:target_user)  { create(:user) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "does not include the user in its scope" do
      expect(resolved_scope).not_to include(target_user)
    end
  end

  context "given a sysadmin and a their User" do
    let(:current_user) { create(:user, :sys_admin) }
    let(:target_user)  { create(:user) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given a sysadmin and a different User" do
    let(:current_user) { create(:user, :sys_admin) }
    let(:target_user)  { create(:user) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given an admin and their User" do
    let(:current_user) { create(:user, :admin) }
    let(:target_user)  { current_user }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given an admin and a different User" do
    let(:current_user) { create(:user, :admin) }
    let(:target_user)  { current_user }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end
end
