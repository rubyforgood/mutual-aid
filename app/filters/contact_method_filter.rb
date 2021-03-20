class ContactMethodFilter < BasicFilter
  def self.filter_group
    {
      name: 'Contact Methods',
      filter_options: FilterOptionBlueprint.render_as_hash(ContactMethod.enabled.distinct(:name))
    }
  end

  def filter(scope)
    return super unless parameters
    scope.joins(:person).where(people: { preferred_contact_method: parameters.keys })
  end
end
