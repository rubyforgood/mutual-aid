class ContributionTypeFilter
  PARAM_NAME = 'ContributionType'
  ALLOWED_PARAMS = {PARAM_NAME => {}}

  def self.filter_grouping
    { name: 'Contribution Types', filter_options: [
      { id: "#{PARAM_NAME}[Ask]", name: 'Ask' },
      { id: "#{PARAM_NAME}[Offer]", name: 'Offer' }
    ]}
  end
  ALL_ALLOWED_TYPES = ['Ask', 'Offer'].freeze

  attr_reader :parameters

  def initialize(params)
    @parameters = params
  end

  def scopes
    classes = parameters.blank? || parameters[PARAM_NAME].blank? ? ALL_ALLOWED_TYPES : parameters[PARAM_NAME].keys
    classes.intersection(ALL_ALLOWED_TYPES).map do |type|
      type.constantize.matchable
    end
  end
end
