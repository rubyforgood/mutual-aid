require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(acting_user, target_user) }
  let(:resolved_scope) {
    UserPolicy::Scope.new(acting_user, User.all).resolve
  }

  shared_context "own User" do
    let(:target_user) { acting_user }
  end
  shared_context "different User" do
    let(:target_user) { FactoryBot.create(:user) }
  end

  context "given a normal signed-in user, targeting themselves" do
    include_context "acting as signed-in user"
    include_context "own User"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given a normal signed-in user and a different User" do
    include_context "acting as signed-in user"
    include_context "different User"
    
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "does not include the user in its scope" do
      expect(resolved_scope).not_to include(target_user)
    end
  end

  context "given a sysadmin and a their User" do
    include_context "acting as sysadmin"
    include_context "own User"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given a sysadmin and a different User" do
    include_context "acting as sysadmin"
    include_context "different User"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given an admin and their User" do
    include_context "acting as admin"
    include_context "own User"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end

  context "given an admin and a different User" do
    include_context "acting as admin"
    include_context "different User"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the user in its scope" do
      expect(resolved_scope).to include(target_user)
    end
  end
end
