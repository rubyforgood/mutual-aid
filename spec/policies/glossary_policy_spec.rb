require 'rails_helper'

RSpec.describe GlossaryPolicy do
  subject { GlossaryPolicy.new(user, :glossary) }

  context "user can edit glossary if they are" do
    context "an admin" do
      let(:user) { build(:user, :admin) }
      it { is_expected.to permit_action(:update) }
    end

    context "a sys_admin" do
      let(:user) { build(:user, :sys_admin) }
      it { is_expected.to permit_action(:update) }
    end
  end

  context "user cannot edit glossary if they are" do
    context "a neighbor" do
      let(:user) { build(:user, :neighbor) }
      it { is_expected.not_to permit_action(:update) }
    end

    context "not logged in" do
      let(:user) { nil }
      it { is_expected.not_to permit_action(:update) }
    end
  end
end