class ClaimsController < ApplicationController
  def new
    contribution = Listing.find(params[:contribution_id])
    if contribution.person&.email.blank?
      flash.now[:alert] = "We are sorry, this contributor hasn't provided
                         an email address yet and can't communicate this way".squish
    end
    render locals: { contribution: contribution }
  end

  def create
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution.

    contribution = Listing.find(params[:contribution_id])
    ActiveRecord::Base.transaction do
      Person.create_from_peer_to_peer_params!(current_user, peer_to_peer_match_params) if current_user.person.blank?
      Match.create_match_for_contribution!(contribution, current_user)
      contribution.matched!
    end
    notify_peer_and_log_communication!(contribution)
    redirect_to contribution_path(params[:contribution_id]), notice: 'Claim was successful!'
  rescue
    flash.now[:alert] = 'There was an error. Please try again.'
    render :new, locals: { contribution: contribution }
  end

  private

  def peer_to_peer_match_params
    params.require(:peer_to_peer_match).permit(:peer_alias, :preferred_contact_method_id, :preferred_contact_details, :message)
  end

  def notify_peer_and_log_communication!(contribution)
    peer_to_peer_email = PeerToPeerMatchMailer.peer_to_peer_email(contribution,
                                                                  peer_alias: peer_to_peer_match_params[:peer_alias],
                                                                  message: peer_to_peer_match_params[:message])
    delivery_status = deliver_now_with_error_handling(peer_to_peer_email, "peer_to_peer_email")
    CommunicationLog.log_email(peer_to_peer_email, delivery_status, current_user.person, nil, current_user)
  end
end
