class ConfigurationBlueprint < Blueprinter::Base
  association :categories, blueprint: CategoryBlueprint, view: :with_subcategories do
    Category.visible.roots.includes(:categories)
  end

  association :contact_methods, blueprint: ContactMethodBlueprint do
    ContactMethod.enabled
  end

  association(:service_areas, blueprint: ServiceAreaBlueprint) do
    ServiceArea.all.eager_load(:string_translations, :text_translations)
  end
end
