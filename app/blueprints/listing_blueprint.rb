# frozen_string_literal: true

class ListingBlueprint < Blueprinter::Base
  identifier :id
  fields(
    :description,
    :tag_list,
    :title,
    :type
  )

  view :with_person do
    association :person, blueprint: PersonBlueprint
  end
end
