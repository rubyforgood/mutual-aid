class PersonBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :phone, :skills
  field  :preferred_contact_method

  view :normal do
    association :location, blueprint: LocationBlueprint
  end
end
