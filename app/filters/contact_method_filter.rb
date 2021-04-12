class ContactMethodFilter < BaseFilter
  def self.filter_grouping_name
    'Contact Methods'
  end

  def self.filter_options
    ContactMethod.enabled.distinct(:name)
  end

  def filter(scope)
    return super unless parameters

    # We may want to add contact method logic for community resources. For now, this effectively allows all
    return super unless scope.respond_to? :person_id

    scope.joins(:person).where(people: {preferred_contact_method: parameters.keys})
  end
end
