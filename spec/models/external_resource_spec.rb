require 'rails_helper'

RSpec.describe ExternalResource, type: :model do
  let(:external_resource) { build(:external_resource) }

  describe 'tagging' do
    example 'smoke test' do
      external_resource.tags = ['website', 'childcare']
      external_resource.tags << 'cash'
      external_resource.save

      expect(ExternalResource.with_any_tags('cash')).to match_array([external_resource])
    end
  end
end
