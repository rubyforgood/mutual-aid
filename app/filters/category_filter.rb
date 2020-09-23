class CategoryFilter < BasicFilter
  def self.options
    {
      name: "Categories",
      # Currently only filtering by top-level categories
      filters: FilterOptionsBlueprint.render_as_hash(Category.roots)
    }
  end

  def filter(scope)
    return super unless parameters
    scope.tagged_with(
      Category.roots.where(id: parameters.keys).pluck('name'),
      any: true
    )
  end
end
