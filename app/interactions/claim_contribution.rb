# frozen_string_literal: true

class ClaimContribution < ActiveInteraction::Base
  record :contribution, class: Listing
  hash :claim_params do
    string :peer_alias
    integer :preferred_contact_method_id
    string :preferred_contact_info
    string :message
  end
  object :current_user, class: User

  def execute
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution
    ActiveRecord::Base.transaction do
      add_person_details
      create_match_for_contribution
    end
    email_peer
  end

  private

  def add_person_details
    AddPersonDetailsFromClaimParams.run!(
      user: current_user,
      name: claim_params[:peer_alias],
      preferred_contact_method_id: claim_params[:preferred_contact_method_id],
      contact_info: claim_params[:preferred_contact_info]
    )
  end

  def create_match_for_contribution
    MatchContribution.run!(contribution: contribution, match_with: current_user)
  end

  def email_peer
    EmailPeer.run!(
      contribution: contribution,
      peer_alias: claim_params[:peer_alias],
      message: claim_params[:message],
      user: current_user
    )
  end
end
