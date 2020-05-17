class ContributionsController < ApplicationController
  before_action :authenticate_user!, except: [:combined_form, :respond, :submissions_thank_you]
  before_action :set_contribution, only: [:respond]

  def index
    @filter_types = FilterTypeBlueprint.render([ContributionType, Category, ServiceArea, UrgencyLevel, ContactMethod])
    @contributions = ContributionBlueprint.render(
        BrowseFilter.contributions_for(filter_params),
        profile_path: ->(id) { person_path(id) },
        respond_path: ->(id) { respond_contribution_path(id)}
    )
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def combined_form
  end

  def respond
    @contribution = Listing.find(params[:id])
  end

  def thank_you
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
    models.map { |model| model.filter_by(parameters) }.flatten
  end

  private

  def set_contribution
    type = params["contribution_type"]&.classify || "Ask"
    @contribution = Listing.where(type: type, id: params[:id]).first
  end

end
