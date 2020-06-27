class ContactMethodFilter
  def self.options
    {
      name: 'Contact Methods',
      filters: FilterOptionsBlueprint.render_as_hash(ContactMethod.enabled.distinct(:name))
    }
  end

  def self.filter(relation, _parameters)
    relation
  end
end