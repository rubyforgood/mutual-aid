# frozen_string_literal: true

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

  def create
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution.
    contribution = Listing.find(params[:contribution_id])
    ActiveRecord::Base.transaction do
      add_person_details!
      create_match_for_contribution!(contribution)
    end
    email_peer!(contribution)
    redirect_to contribution_path(params[:contribution_id]), notice: 'Claim was successful!'
  end

  private

  def claim_params
    params.require(:claim).permit(:peer_alias, :preferred_contact_method_id, :preferred_contact_info, :message)
  end

  def add_person_details!
    AddPersonDetailsFromClaimParams.run!(
      user: current_user,
      name: claim_params[:peer_alias],
      preferred_contact_method_id: claim_params[:preferred_contact_method_id],
      contact_info: claim_params[:preferred_contact_info]
    )
  end

  def create_match_for_contribution!(contribution)
    CreateMatchForContribution.run!(contribution: contribution, match_with: current_user)
  end

  def email_peer!(contribution)
    EmailPeer.run!(
      contribution: contribution,
      peer_alias: claim_params[:peer_alias],
      message: claim_params[:message],
      user: current_user
    )
  end

  def current_person
    current_user.person
  end
end
