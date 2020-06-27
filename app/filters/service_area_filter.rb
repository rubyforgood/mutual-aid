class ServiceAreaFilter
  def self.options
    {
      name: 'Service Areas',
      filters: FilterOptionsBlueprint.render_as_hash(ServiceArea.i18n)
    }
  end

  def self.filter(relation, _parameters)
    relation
  end
end