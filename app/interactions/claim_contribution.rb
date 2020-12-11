# frozen_string_literal: true

class ClaimContribution < ActiveInteraction::Base
  record :contribution, class: Listing
  hash :claim_params do
    string :peer_alias
    string :email
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
    if current_user.person.blank?
      Person.create!(new_person_params)
    else
      current_user.person.update!(email: claim_params[:email])
    end
  end

  def new_person_params
    {
      name: claim_params[:peer_alias],
      preferred_contact_method: ContactMethod.email,
      user: current_user,
      email: claim_params[:email]
    }
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
