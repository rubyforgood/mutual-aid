# This class has information about how we sort and filter categories
# and is capable of accepting a model scope and adding additional
# `where` clauses to it in order to filter the message

# BasicFilter is more like an abstract parent class, but it also serves
# as a NullObject version of the filter, if you want one
class BasicFilter
  # This method should be overridden to return a hash with the following keys:
  # * :name => a short string that the user will see that describes what type of filters these are
  # * :filters => the output a call to FilterOptionsBlueprint.render_as_hash that represent each filter option to check or uncheck
  def self.options
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
