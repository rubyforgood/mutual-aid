class CategoryBlueprint < Blueprinter::Base
  identifier :id

  field :name
  field :description

  view :with_subcategories do
    # Note we are _not_ propogating the :with_subcategories view to children.
    # This is intentional because we don't currently have multiply
    # nested categories so we don't need to dig any deeper.
    association :subcategories, blueprint: CategoryBlueprint do |category|
      category.categories.visible
    end
  end
end
