require 'rails_helper'

RSpec.describe CommunityResource, type: :model do
  let(:community_resource) { build(:community_resource) }

  describe 'tagging' do
    example 'smoke test' do
      community_resource.tags = ['website', 'childcare']
      community_resource.tags << 'cash'
      community_resource.save

      expect(CommunityResource.with_any_tags('cash')).to match_array([community_resource])
    end
  end
end
