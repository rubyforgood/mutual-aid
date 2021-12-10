# frozen_string_literal: true

class ContactMethodBlueprint < Blueprinter::Base
  identifier :id

  field :name

  view :with_form_fields do
    field :field, name: :field_name
    field :label, name: :field_label
  end
end
