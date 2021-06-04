# frozen_string_literal: true

# FilterOptionsBlueprint emits a structure that the browse Vue page can turn
# into checkboxes or other form UI elements to filter a list of contributions
#
# We assume that there's a top level type of filter (e.g ContactMethodFilter)
# that then references a series of these FilterOptionBlueprint objects for
# each element (e.g. each available contact method)
class FilterOptionBlueprint < Blueprinter::Base
  # The identifier here needs to be in a format that the BrowseFilter can then
  # interpret and use to filter results
  identifier :id do |filter_option, _options|
    "#{filter_option.class}[#{filter_option.id}]"
  end

  # This is currently used as a display name so people can understand
  # which each option represents
  field :name
end
