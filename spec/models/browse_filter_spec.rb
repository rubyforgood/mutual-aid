require 'rails_helper'

RSpec.describe BrowseFilter do
  let(:all_models) { ContributionType::TYPES.map(&:model)}
  it 'ignores urgency levels if all urgency levels are checked because urgency levels are not fully implemented' do
    pending
    unmodified_scope = double
    all_models.each do |model_class|
      expect(model_class).to receive(:unmatched).and_return(unmodified_scope)
    end
    expect(unmodified_scope).not_to receive(:where)
    all_urgency_level_ids = UrgencyLevel::TYPES.map(&:id)
    BrowseFilter.new('UrgencyLevel' => all_urgency_level_ids).contributions
  end

  it 'will query for urgency levels if only one urgency level is checked' do
    pending
    used_scope = double
    all_models.each do |model_class|
      expect(model_class).to receive(:unmatched).and_return(used_scope)
    end
    one_urgency_level_id = [UrgencyLevel::TYPES.sample.id]
    expect(used_scope).to receive(:where).with(urgency_level_id: one_urgency_level_id).exactly(ContributionType::TYPES.length).times
    BrowseFilter.new('UrgencyLevel' => one_urgency_level_id).contributions
  end
end
