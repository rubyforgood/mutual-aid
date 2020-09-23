class ServiceAreaFilter < BasicFilter
  def self.options
    {
      name: 'Service Areas',
      filters: FilterOptionsBlueprint.render_as_hash(ServiceArea.i18n)
    }
  end

  def filter(scope)
    return super unless parameters
    scope.where(service_area_id: parameters.keys)
  end
end
