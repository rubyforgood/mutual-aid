# frozen_string_literal: true

class ContributionsController < ApplicationController
  before_action :authenticate_user!, unless: :peer_to_peer_mode?
  skip_after_action :verify_policy_scoped

  # FIXME: this should probably be wrapped by a policy scope?
  def index
    @filter_types = FilterTypeBlueprint.render([ContributionType, Category, ServiceArea, UrgencyLevel, ContactMethod])
    filter = BrowseFilter.new(filter_params)
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

  def filter_params
    return {} unless allowed_params&.to_h.any?

    allowed_params.to_h.filter { |key, _v| BrowseFilter::ALLOWED_PARAMS.keys.include? key}.tap do |hash|
      hash.each_key { |key| hash[key] = hash[key].keys}
    end
  end

  def allowed_params
    @allowed_params ||= params.permit(:format, **BrowseFilter::ALLOWED_PARAMS)
  end

  def contribution
    @contribution ||= authorize Listing.find(params[:id]), policy_class: ContributionPolicy
  end
  helper_method :contribution
end
