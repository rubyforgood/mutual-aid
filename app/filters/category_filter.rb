class CategoryFilter
  def self.options
    {
      name: "Categories",
      # Currently only filtering by top-level categories
      filters: FilterOptionsBlueprint.render_as_hash(Category.roots)
    }
  end

  def self.filter(relation, parameters)
    ids = parameters["Category"]
    return relation if ids.blank?
    relation.tagged_with(Category.roots.where(id: ids).pluck('name'), any: true)
  end
end