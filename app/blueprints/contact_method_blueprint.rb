class ContactMethodBlueprint < Blueprinter::Base
  identifier :id

  field :name
  field :field, name: :field_name
  field :label, name: :field_label
end
