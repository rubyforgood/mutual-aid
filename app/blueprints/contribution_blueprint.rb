class ContributionBlueprint < Blueprinter::Base
  identifier :id
  association :categories_for_tags, name: :category_tags, blueprint: DefaultBlueprint
  association :service_area, blueprint: DefaultBlueprint
  association :contact_types, blueprint: DefaultBlueprint do |contribution, _options|
    [contribution.person.preferred_contact_method]
  end
  association :urgency, blueprint: DefaultBlueprint do |contribution, _options|
    UrgencyLevel.find(contribution.urgency_level_id)
  end
  fields :title, :description, :inexhaustible
  field :created_at do |contribution, _options|
    contribution.created_at.to_f * 1000 # Javascript wants miliseconds, not seconds
  end
  field :type, name: :contribution_type
  field :profile_path do |contribution, options|
    options[:profile_path]&.call(contribution.person_id)
  end
  field :respond_path do |contribution, options|
    options[:respond_path]&.call(contribution.id)
  end
  field :match_path do |contribution, options|
    options[:match_path]&.call(contribution.id)
  end
end
