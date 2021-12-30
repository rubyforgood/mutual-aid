class ServiceAreaFilter < BaseFilter
  def self.filter_grouping_name
    'Service Areas'
  end

  def self.filter_options
    ServiceArea.i18n
  end

  def filter(scope)
    return super unless parameters
    scope.in_service_areas(parameters.keys)
  end
end
