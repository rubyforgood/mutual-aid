class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  CONTRIBUTION_MODELS = { 'Ask' => Ask, 'Offer' => Offer }.freeze # TODO - add CommunityResource

  def index
    # TODO: these json fixtures are to be replaced with actual generators of data
    sample_data = File.open('lib/listings.json') do |file|
      JSON.load(file)
    end
    sample_filter_categories = File.open('lib/filterCategories.json') do |file|
      JSON.load(file)
    end
    @contributions = sample_data["contributions"]
    @filter_categories = sample_filter_categories
  end

  def allowed_params
    @allowed_params ||= params.permit('contribution_type', 'format', 'Category' => {}, 'ServiceArea' => {})
  end

  def filter_params
    return Hash.new unless allowed_params && allowed_params.to_h.any?
    allowed_params.keys.intersection(['Category', 'ServiceArea']).each_with_object({}) do |model_name, data|
      data[model_name.underscore] = allowed_params[model_name].keys
    end
  end

  def contribution_type_params
    type_list = allowed_params && allowed_params['contribution_type']
    return unless type_list
    type_list.split(',').map {|name| CONTRIBUTION_MODELS[name]}.compact
  end

  def contributions_for(parameters, models = CONTRIBUTION_MODELS.values)
    models.map { |model| model.tagged_with(parameters) }.flatten
  end

end
