class ContributionsController < ApplicationController
  before_action :authenticate_user!, except: [:combined_form, :respond, :thank_you]
  before_action :set_contribution, only: [:respond, :triage]

  layout "without_navbar", only: [:thank_you]

  def index
    
    @filter_types = FilterTypeBlueprint.render([ContributionType, Category, ServiceArea, UrgencyLevel, ContactMethod])
    filter = BrowseFilter.new(filter_params, self)
    @contributions = ContributionBlueprint.render(filter.contributions, **filter.options)
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def show
    contribution = Listing.find(params[:id])

    render(
      :show,
      locals: {
        contribution: contribution,
      }
    )
  end

  def claim_contribution_form
    contribution = Listing.find(params[:id])
    if contribution.person&.email.blank?
      flash.now[:alert] = "We are sorry, this contributor hasn't provided
                         an email address yet and can't communicate this way".squish
    end
    render locals: { contribution: contribution }
  end

  def claim_contribution
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution.

    contribution = Listing.find(params[:id])
    ActiveRecord::Base.transaction do
      Person.create_from_peer_to_peer_params!(current_user, peer_to_peer_match_params) if current_user.person.blank?
      Match.create_match_for_contribution!(contribution, current_user)
      contribution.matched!
    end
    notify_peer_and_log_communication!(contribution)
    redirect_to contribution_path(params[:id]), notice: 'Claim was successful!'
  rescue
    render(
      :claim_contribution_form,
      locals: { contribution: contribution },
      notice: 'There was an error. Please try again.'
    )
  end

  def combined_form
  end

  def respond
    @communication_logs = CommunicationLog.where(person: @contribution.person).order(sent_at: :desc)
  end

  def thank_you
  end

  def triage
  end

  def triage_update
    @contribution = Listing.find(params[:id])
    contribution_params = params[@contribution.type.downcase.to_sym]
    title = contribution_params[:title]
    description = contribution_params[:description]
    inexhaustible = contribution_params[:inexhaustible]

    if @contribution.update(title: title, description: description, inexhaustible: inexhaustible)
      # CommunicationLog.create!(person: @contribution.person,
      #                          sent_at: Time.current,
      #                          subject: "triaged by #{current_user.name}",
      #                          delivery_status: "connected",
      #                          delivery_method: @contribution.person.preferred_contact_method)
      redirect_to respond_contribution_path(@contribution), notice: 'Contribution was successfully updated.'
    else
      render triage_contribution_path(@contribution)
    end
  end

  private

  def filter_params
    return Hash.new unless allowed_params && allowed_params.to_h.any?
    allowed_params.to_h.filter { |key, _v| BrowseFilter::ALLOWED_PARAMS.keys.include? key}.tap do |hash|
      hash.keys.each { |key| hash[key] = hash[key].keys}
    end
  end

  def allowed_params
    @allowed_params ||= params.permit(:format, **BrowseFilter::ALLOWED_PARAMS)
  end

  def set_contribution
    @contribution = Listing.find(params[:id])
  end

  def peer_to_peer_match_params
    params.require(:peer_to_peer_match).permit(:peer_alias, :preferred_contact_method_id, :preferred_contact_details, :message)
  end

  def notify_peer_and_log_communication!(contribution)
    peer_to_peer_email = PeerToPeerMatchMailer.peer_to_peer_email(contribution, peer_to_peer_match_params)
    delivery_status = deliver_now_with_error_handling(peer_to_peer_email, "peer_to_peer_email")
    CommunicationLog.log_email(peer_to_peer_email, delivery_status, current_user.person, nil, current_user)
  end
end
