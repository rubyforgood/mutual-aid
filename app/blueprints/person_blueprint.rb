class PersonBlueprint < Blueprinter::Base
  identifier :id

  fields :preferred_contact_method, :phone, :email

  view :normal do
    association :location, blueprint: LocationBlueprint
  end
end
