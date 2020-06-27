class CategoryFilter
  def self.options
    {
      name: "Categories",
      # Currently only filtering by top-level categories
      filters: FilterOptionsBlueprint.render_as_hash(Category.roots)
    }
  end

  def intialize(parameters)
    @parameters = parameters
  end
  def filter
  end
end