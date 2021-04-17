# This class has information about how we sort and filter groupings
# and is capable of accepting a model scope and adding additional
# `where` clauses to it in order to further filter the model scope

# BaseFilter is more like an abstract parent class, but it also serves
# as a NullObject version of the filter grouping, if you want one
class BaseFilter
  # This constant should be overriden if you need the ContributionController to
  # accept additional parameters for this filter to work
  ALLOWED_PARAMS = {}

  # This method should be overridden to return a hash with the following keys:
  # * :name => a short string that the user will see that describes what type of filters these are
  # * :filters => the output a call to FilterOptionBlueprint.render_as_hash that represent each filter option to check or uncheck
  def self.filter_grouping
    {}
  end

  attr_reader :parameters

  def initialize(parameters)
    @parameters = parameters
  end

  # By default, return the model scope unfiltered
  def filter(scope)
    scope
  end
end
