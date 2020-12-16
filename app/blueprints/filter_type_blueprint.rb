# frozen_string_literal: true

# FilterTypeBlueprint
#
# The `.render` method will accept a class (usually an ActiveRecord::Model) or an array of classes 
# and serialize the classes consistent with what the Filter component in Vue will expect.
#
# The class must have a `.as_filter_types` method or scope that returns a list of instances that 
# respond to `#name` and `#id`.

class FilterTypeBlueprint < Blueprinter::Base
  identifier :name do |klass, _options|
    klass.to_s.titleize.pluralize
  end

  association :as_filter_types, name: :filters, blueprint: SubfilterTypeBlueprint
end