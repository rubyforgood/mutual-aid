class ClaimsController < ApplicationController
  def new
    contribution = Listing.find(params[:contribution_id])
    if contribution.person&.email.blank?
      flash.now[:alert] = "We are sorry, this contributor hasn't provided
                           an email address yet and can't communicate this way".squish
    end
    render locals: {
      contribution: contribution,
      preferred_contact_method_id: current_person&.preferred_contact_method&.id,
      preferred_contact_info: current_person&.preferred_contact_info,
    }
  end

  # FIXME: extract into an interactor
  def create
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution.
    contribution = Listing.find(params[:contribution_id])
    ActiveRecord::Base.transaction do
      if current_person.blank?
        Person.create_from_peer_to_peer_params!(current_user, name: claim_params[:peer_alias],
                                                preferred_contact_method_id: claim_params[:preferred_contact_method_id],
                                                contact_info: claim_params[:preferred_contact_info])
      elsif current_person.present? && current_person.email.blank?
        current_person.update!(email: claim_params[:preferred_contact_info])
      end
      Match.create_match_for_contribution!(contribution, current_user)
      contribution.matched!
    end
    notify_peer_and_log_communication!(contribution)
    redirect_to contribution_path(params[:contribution_id]), notice: 'Claim was successful!'
  end

  private

  def claim_params
    params.require(:claim).permit(:peer_alias, :preferred_contact_method_id, :preferred_contact_info, :message)
  end

  def notify_peer_and_log_communication!(contribution)
    peer_to_peer_email = PeerToPeerMatchMailer.peer_to_peer_email(
      contribution,
      peer_alias: claim_params[:peer_alias],
      message: claim_params[:message],
    )

    status = Messenger.new(peer_to_peer_email, "peer_to_peer_email").deliver_now

    CommunicationLog.log_email(
      email: peer_to_peer_email,
      delivery_status: status,
      person: current_user.person,
      initiator: current_user,
    )
  end

  def current_person
    current_user.person
  end
end
