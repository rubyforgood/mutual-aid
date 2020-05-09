class ServiceAreaBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description

  view :normal do
    association :location, blueprint: LocationBlueprint
  end
end
