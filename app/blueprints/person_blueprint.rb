class PersonBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :phone
  fields :preferred_contact_method_id, :phone, :email # TODO - am i merging this correctly?

  view :normal do
    association :location, blueprint: LocationBlueprint

    # TODO: get this working so the form retains preferrence on error
    # association :preferred_contact_method, blueprint: ContactMethod
  end
end
