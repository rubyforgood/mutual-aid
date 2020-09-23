class ServiceAreaBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :location

  view :with_location do
    association :location, blueprint: LocationBlueprint
  end
end
