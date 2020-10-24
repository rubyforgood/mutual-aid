# frozen_string_literal: true

class LocationTypeBlueprint < Blueprinter::Base
  identifier :id

  field :name
  field :description
end
