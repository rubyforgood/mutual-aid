# CategoryBlueprint
#
# The `.render` method will accept a class (usually an ActiveRecord::Model) or an array of classes 
# and serialize the classes consistent with what the Filter component in Vue will expect.
#
# The class must have a `.as_filter_categories` method or scope that returns a list of instances that 
# respond to `#name` and `#id`.

class CategoryBlueprint < Blueprinter::Base
  identifier :name do |klass, _options|
    klass.to_s.titleize.pluralize
  end

  association :as_filter_categories, name: :filters, blueprint: SubCategoryBlueprint
end