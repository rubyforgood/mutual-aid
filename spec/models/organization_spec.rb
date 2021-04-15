# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'is_host validation' do
    subject(:organization) { build :organization, is_host: true }

    context 'with an existing instance owner' do
      before do
        Organization.host_organization || create(:organization, is_host: true)
      end

      it { is_expected.to_not be_valid }
    end

    context 'without an existing instance owner' do
      before do
        # in case test db was seeded
        Organization.host_organization.update!(is_host: false) if Organization.host_organization
      end

      it { is_expected.to be_valid }
    end
  end
end
