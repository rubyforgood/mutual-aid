class ListingBlueprint < Blueprinter::Base
  identifier :id
  fields(
    :description,
    :tag_list,
    :title,
    :type
  )

  field :errors do |listing|
    listing.errors.as_json(full_messages: true)
  end

  view :normal do
    association :person, blueprint: PersonBlueprint, view: :normal
  end
end
