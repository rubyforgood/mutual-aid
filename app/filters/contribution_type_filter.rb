class ContributionTypeFilter
  def self.options
    { name: 'Contribution Types', filters: [
      { id: 'ContributionType[Ask]', name: 'Ask' },
      { id: 'ContributionType[Offer]', name: 'Offer' }
    ]}
  end
  ALL_ALLOWED_TYPES = ['Ask', 'Offer'].freeze

  attr_reader :parameters

  def initialize(params)
    @parameters = params
  end

  def scopes
    classes = parameters.blank? ? ALL_ALLOWED_TYPES : parameters.keys
    classes.intersection(ALL_ALLOWED_TYPES).map do |type|
      type.constantize.matchable
    end
  end
end
