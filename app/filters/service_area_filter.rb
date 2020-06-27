class ServiceAreaFilter
  def self.options
    {
      name: 'Service Areas',
      filters: FilterOptionsBlueprint.render_as_hash(ServiceArea.i18n)
    }
  end

  def filter(model, parameters)
  end
end