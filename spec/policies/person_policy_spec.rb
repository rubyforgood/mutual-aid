require 'rails_helper'

RSpec.describe PersonPolicy do
  subject { PersonPolicy.new(user, person) }

  let(:resolved_scope) {
    PersonPolicy::Scope.new(user, Person.all).resolve
  }

  let(:user)         { create(:user) }
  let(:own_person)   { create(:person, user: user) }
  let(:other_person) { create(:person) }


  context "given a normal signed-in user and their Person" do
    let(:person) { own_person }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given a normal signed-in user and a different Person" do
    let(:person) { other_person }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "does not include the person in its scope" do
      expect(resolved_scope).not_to include(person)
    end
  end

  context "given a sysadmin and a their Person" do
    let(:user) { create(:user, :sys_admin) }
    let(:person) { own_person }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given a sysadmin and a different Person" do
    let(:user) { create(:user, :sys_admin) }
    let(:person) { other_person }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given an admin and their Person" do
    let(:user) { create(:user, :admin) }
    let(:person) { own_person }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end

  context "given an admin and a different Person" do
    let(:user) { create(:user, :admin) }
    let(:person) { other_person }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:destroy) }

    it "includes the person in its scope" do
      expect(resolved_scope).to include(person)
    end
  end
end
