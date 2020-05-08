class ListingBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :type

  field :errors do |listing, _options|
    listing.errors.as_json(full_messages: true)
  end

  view :normal do
    association :person, blueprint: PersonBlueprint, view: :normal
  end
end
