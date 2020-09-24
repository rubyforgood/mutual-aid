class ContributionsController < ApplicationController
  before_action :authenticate_user!, except: [:combined_form, :respond, :thank_you]
  before_action :set_contribution, only: [:respond, :triage]
  before_action :check_peer_to_peer_system_setting, only: [:show, :claim_contribution, :claim_contribution_form]

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
    render locals: { contribution: contribution }
  end

  def claim_contribution
    ActiveRecord::Base.transaction do
      create_person_record! if current_user.person.blank?
      match = create_match_for_contribution!
      create_communication_log!(match)
    end
    # send an email from do not reply address
    redirect_to contribution_path(params[:id])
  rescue
    redirect_to :back
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

  def check_peer_to_peer_system_setting
    # raise Unauthorized exception unless SystemSetting.allow_peer_to_peer_matching?
  end

  def peer_to_peer_match_params
    params.require(:peer_to_peer_match).permit(:peer_alias, :preferred_contact_method_id, :preferred_contact_details, :message)
  end

  def create_person_record!
    contact_method = ContactMethod.find(peer_to_peer_match_params[:preferred_contact_method_id])
    contact_method_details = if contact_method.name == "Email"
                               { email: peer_to_peer_match_params[:preferred_contact_details] }
                             else
                               { phone: peer_to_peer_match_params[:preferred_contact_details] }
                             end

    person_params = { name: peer_to_peer_match_params[:peer_alias],
                      preferred_contact_method: contact_method,
                      user: current_user }
    Person.create!(person_params.merge(contact_method_details))
  end

  def create_match_for_contribution!
    contribution = Listing.find(params[:id])
    match_params = if contribution.ask?
                      { receiver: contribution, provider: create_offer_for_ask!(contribution) }
                    elsif contribution.offer? # TODO: check if community resource type when it's added
                      { receiver: create_ask_for_offer!(contribution), provider: contribution }
                    end
    Match.create!(match_params)
  end

  def create_offer_for_ask!(contribution)
    Offer.create!(person: current_user.person, service_area: contribution.service_area)
  end

  def create_ask_for_offer!(contribution)
    Ask.create!(person: current_user.person, service_area: contribution.service_area)
  end

  def create_communication_log!(match)
    communication_log_params = {
                                  person: current_user.person,
                                  match: match,
                                  delivery_method_id: peer_to_peer_match_params[:preferred_contact_method_id],
                                  body: peer_to_peer_match_params[:message],
                                }
    CommunicationLog.create!(communication_log_params)
  end
end
