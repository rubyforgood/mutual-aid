require 'rails_helper'

RSpec.describe PersonPolicy do
  subject { PersonPolicy.new(acting_user, person) }
  let(:resolved_scope) {
    PersonPolicy::Scope.new(acting_user, Person.all).resolve
  }

  shared_context "own Person" do
    let(:person) { FactoryBot.create(:person, user: acting_user) }
  end
  shared_context "different Person" do
    let(:person) { FactoryBot.create(:person) }
  end

  context "given a normal signed-in user and their Person" do
    include_context "acting as signed-in user"
    include_context "own Person"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given a normal signed-in user and a different Person" do
    include_context "acting as signed-in user"
    include_context "different Person"
    
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "does not include the person in its scope" do
      expect(resolved_scope).not_to include(person)
    end
  end

  context "given a sysadmin and a their Person" do
    include_context "acting as sysadmin"
    include_context "own Person"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given a sysadmin and a different Person" do
    include_context "acting as sysadmin"
    include_context "different Person"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given an admin and their Person" do
    include_context "acting as admin"
    include_context "own Person"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given an admin and a different Person" do
    include_context "acting as admin"
    include_context "different Person"
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end
end
