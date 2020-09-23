# frozen_string_literal: true

class ContributionsController < ApplicationController
  before_action :authenticate_user!, unless: :peer_to_peer_mode?
  skip_after_action :verify_policy_scoped

  # FIXME: this should probably be wrapped by a policy scope?
  def index
    @filter_types = BrowseFilter.filter_options_json
    # The BrowserFilter takes the result of the parameters from the FilterType checkboxes and returns a list of contributions
    filter = BrowseFilter.new(allowed_params)
    @contributions = ContributionBlueprint.render(filter.contributions, contribution_blueprint_options)
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def show
    @communication_logs = CommunicationLog.where(person: contribution.person).order(sent_at: :desc)
  end

  def edit; end

  def update
    contribution_params = params[contribution.type.downcase.to_sym]
    title = contribution_params[:title]
    description = contribution_params[:description]
    inexhaustible = contribution_params[:inexhaustible]

    if contribution.update(title: title, description: description, inexhaustible: inexhaustible)
      # CommunicationLog.create!(person: contribution.person,
      #                          sent_at: Time.current,
      #                          subject: "triaged by #{current_user.name}",
      #                          delivery_status: "connected",
      #                          delivery_method: contribution.person.preferred_contact_method)
      redirect_to contribution_path(contribution), notice: 'Contribution was successfully updated.'
    else
      render :edit
    end
  end

  private

  def peer_to_peer_mode?
    @system_setting.peer_to_peer?
  end

  def contribution_blueprint_options
    options = {}
    options[:view_path] = ->(id) { contribution_path(id) }
    options
  end

  def allowed_params
    params.permit(:format, BrowseFilter::ALLOWED_PARAMS_FILTER)
  end

  def contribution
    @contribution ||= authorize Listing.find(params[:id]), policy_class: ContributionPolicy
  end
  helper_method :contribution
end
