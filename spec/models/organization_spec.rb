# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'is_instance_owner validation' do
    subject(:organization) { build :organization, is_instance_owner: true }

    context 'with an existing instance owner' do
      before do
        Organization.current_organization || create(:organization, is_instance_owner: true)
      end

      it { is_expected.to_not be_valid }
    end

    context 'without an existing instance owner' do
      before do
        # in case test db was seeded
        Organization.current_organization.update!(is_instance_owner: false) if Organization.current_organization
      end

      it { is_expected.to be_valid }
    end
  end
end
