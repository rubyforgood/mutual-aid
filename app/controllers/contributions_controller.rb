class ContributionsController < ApplicationController
  before_action :authenticate_user!, except: [:combined_form, :respond, :thank_you]
  before_action :set_contribution, only: [:respond]

  def index
    @filter_types = FilterTypeBlueprint.render([Category, ServiceArea])
    contribution_types = contribution_type_params
    contribution_types ||= CONTRIBUTION_MODELS.values
    @contributions = ContributionBlueprint.render(contributions_for(filter_params, contribution_types))
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def combined_form
  end

  def respond
    @contribution = Listing.find(params[:id])
    @communication_logs = CommunicationLog.where(person: @contribution.person).order(sent_at: :desc)
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
