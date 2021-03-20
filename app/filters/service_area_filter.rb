class ServiceAreaFilter < BasicFilter
  def self.filter_group
    {
      name: 'Service Areas',
      filter_options: FilterOptionBlueprint.render_as_hash(ServiceArea.i18n)
    }
  end

  def filter(scope)
    return super unless parameters
    scope.where(service_area_id: parameters.keys)
  end
end
