class ContributionBlueprint < Blueprinter::Base
  identifier :id
  association :categories_for_tags, name: :category_tags, blueprint: DefaultBlueprint
  association :service_area, blueprint: DefaultBlueprint
  association :contact_types, blueprint: DefaultBlueprint do |contribution, _options|
    [contribution.person.preferred_contact_method]
  end
  # commenting out bc I branched of browse-improvements
  # association :urgency, blueprint: DefaultBlueprint do |contribution, _options|
  #   UrgencyLevel.find(contribution.urgency_level_id)
  # end
  fields :title, :description
  field :created_at do |contribution, _options|
    contribution.created_at.to_formatted_s(:iso8601)
  end
  field :type, name: :contribution_type
end
