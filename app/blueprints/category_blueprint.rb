class CategoryBlueprint < Blueprinter::Base
  identifier :id

  field :name
  field :description

  view :normal do
    # Note we are _not_ propogating the :normal view to children.
    # This is intentional because we don't currently have multiply
    # nested categories so we don't need to dig any deeper.
    association :categories, name: :subcategories, blueprint: CategoryBlueprint
  end
end
