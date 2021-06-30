# frozen_string_literal: true

class ContributionsController < ApplicationController
  before_action :authenticate_user!, unless: :peer_to_peer_mode?
  skip_after_action :verify_policy_scoped
  # FIXME: this should probably be wrapped by a policy scope?
  # Nomenclature note:
  # Filter —
  #   An object that handles the logic or action of filtering
  # Filter Grouping —
  #   A higher-level category or other grouping of filter options. Example: Contact Method can be
  # a *filter grouping* that then has *filter options* for things like "email" or "text message"
  # Filter Option —
  #   An individual item that can be chosen to change what's filtered. Each *filter option* is
  # associated to one and only one *filter grouping*

  def index
    @filter_groupings = BrowseFilter.filter_groups_json
    # The BrowserFilter takes the result of the parameters from the filter checkboxes and returns a list of contributions
    filter = BrowseFilter.new(allowed_params)
    @contributions = ContributionBlueprint.render(
      filter.contributions,
      show_view_path: true,
      current_user: context.user
    )
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

  def allowed_params
    params.permit(:format, BrowseFilter::ALLOWED_PARAMS)
  end

  def contribution
    @contribution ||= authorize Listing.find(params[:id]), policy_class: ContributionPolicy
  end
  helper_method :contribution
end
