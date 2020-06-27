class ContributionTypeFilter
  def self.options
    { name: 'Contribution Types', filters: [
      { id: 'ContributionType[Ask]', name: 'Ask' },
      { id: 'ContributionType[Offer]', name: 'Offer' }
    ]}
  end

  def self.filter(relation, _parameters)
    relation
  end
end
