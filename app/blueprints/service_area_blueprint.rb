# frozen_string_literal: true

class ServiceAreaBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description

  view :with_location do
    association :location, blueprint: LocationBlueprint
  end
end
