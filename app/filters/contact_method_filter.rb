class ContactMethodFilter < BaseFilter
  PARAM_NAME = 'ContactMethod'
  ALLOWED_PARAMS = {PARAM_NAME => {}}

  def self.filter_grouping
    {
      name: 'Contact Methods',
      filter_options: FilterOptionBlueprint.render_as_hash(ContactMethod.enabled.distinct(:name))
    }
  end

  def filter(scope)
    return super if parameters[PARAM_NAME].blank?
    scope.joins(:person).where(people: { preferred_contact_method: parameters[PARAM_NAME].keys })
  end
end
