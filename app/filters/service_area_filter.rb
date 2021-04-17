class ServiceAreaFilter < BaseFilter
  PARAM_NAME = 'ServiceArea'
  ALLOWED_PARAMS = {PARAM_NAME => {}}

  def self.filter_grouping
    {
      name: 'Service Areas',
      filter_options: FilterOptionBlueprint.render_as_hash(ServiceArea.i18n)
    }
  end

  def filter(scope)
    return super if parameters[PARAM_NAME].blank?
    scope.where(service_area_id: parameters[PARAM_NAME].keys)
  end
end
