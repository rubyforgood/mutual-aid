class ContactMethodFilter < BasicFilter
  def self.options
    {
      name: 'Contact Methods',
      filters: FilterOptionsBlueprint.render_as_hash(ContactMethod.enabled.distinct(:name))
    }
  end

  def filter(scope)
    return super unless parameters
    scope.joins(:person).where(people: { preferred_contact_method: parameters.keys })
  end
end
