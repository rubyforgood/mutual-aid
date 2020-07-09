class ConfigurationBlueprint < Blueprinter::Base
  association :categories, blueprint: CategoryBlueprint, view: :with_subcategories do
    Category.visible.roots.includes(:categories)
  end

  association :contact_methods, blueprint: ContactMethodBlueprint do
    ContactMethod.enabled
  end

  association :location_types, blueprint: LocationTypeBlueprint do
    LocationType.visible
  end

  association(:service_areas, blueprint: ServiceAreaBlueprint) do
    ServiceArea.publicly_visible.eager_load(:string_translations)
  end
end
