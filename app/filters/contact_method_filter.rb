class ContactMethodFilter
  def self.options
    {
      name: 'Contact Methods',
      filters: FilterOptionsBlueprint.render_as_hash(ContactMethod.enabled.distinct(:name))
    }
  end

  def filter(model, parameters)
  end
end