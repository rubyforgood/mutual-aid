# frozen_string_literal: true

class PersonBlueprint < Blueprinter::Base
  extend BlueprintAuthorization

  identifier :id

  fields :name, :email, :phone, :skills
  field  :preferred_contact_method

  view :with_location do
    association :location, blueprint: LocationBlueprint, view: :with_location_type
  end
end
