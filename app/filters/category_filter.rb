class CategoryFilter < BaseFilter
  PARAM_NAME = 'Category'
  ALLOWED_PARAMS = {PARAM_NAME => {}}

  def self.filter_grouping
    {
      name: "Categories",
      # Currently only filtering by top-level categories
      filter_options: FilterOptionBlueprint.render_as_hash(Category.roots)
    }
  end

  def filter(scope)
    return super if parameters[PARAM_NAME].blank?
    scope.tagged_with(
      Category.roots.where(id: parameters[PARAM_NAME].keys).pluck('name'),
      any: true
    )
  end
end
