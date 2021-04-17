# frozen_string_literal: true

# BrowseFilter lets the browse page filter contributions by parameters, delegating much of the actual filtering
# to the classes listed in BrowseFilter::FILTER_CLASSES
class BrowseFilter
  FILTER_CLASSES = [
    CategoryFilter,
    ServiceAreaFilter,
    ContactMethodFilter,
    ContributionTypeFilter,
    # UrgencyLevelFilter
  ].freeze
  ALLOWED_PARAMS = FILTER_CLASSES.each_with_object({}) do |filter, hash|
    hash.merge! filter::ALLOWED_PARAMS
  end.freeze

  attr_reader :parameters

  def self.filter_groupings_json
    FILTER_CLASSES.map(&:filter_grouping).to_json
  end

  def initialize(parameters)
    @parameters = parameters
  end

  # Return a filtered array of contributions
  def contributions
    # ContributionTypeFilter is special and needs to come first because of Single Table Inheretence
    # Currently, the only other option seemed to be pulling in a gem that supports UNION queries in SQL
    starting_relations = ContributionTypeFilter.new(parameters).scopes

    # So using whatever relations ContributionTypeFilter gives us (unmatched asks, unmatched offers, etc.)
    @contributions ||= FILTER_CLASSES.reduce(starting_relations) do |resulting_relations, filter_class|
      # Skip ContributionTypeFilter because we've already used it
      next resulting_relations if filter_class == ContributionTypeFilter

      # then filter the relations further based on the rules in each class for doing so
      resulting_relations.map do |scope|
        filter_class.new(parameters).filter(scope)
      end
    end.flatten
  end
end
