class UrgencyFilter < BaseFilter
  PARAM_NAME = 'UrgencyLevel'
  ALLOWED_PARAMS = {PARAM_NAME => {}}

  def self.filter_grouping
    {
      name: 'Urgency',
      filter_options: FilterOptionBlueprint.render_as_hash(UrgencyLevel::TYPES)
    }
  end

  def filter(scope)
    return super if parameters[PARAM_NAME].blank?
    scope.where(urgency_level_id: parameters[PARAM_NAME].keys)
  end
end