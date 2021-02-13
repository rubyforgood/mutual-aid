# frozen_string_literal: true

class ClaimContribution < ActiveInteraction::Base
  string :peer_alias
  string :message
  record :contribution, class: Listing
  object :current_user, class: User

  def execute
    # TODO: Need to handle race conditions to prevent creating multiple matches for same contribution
    ActiveRecord::Base.transaction do
      ensure_person_record
      create_match_for_contribution
    end
    email_peer
  end

  private

  def ensure_person_record
    if current_user.person.blank?
      Person.create!(
        name: peer_alias,
        user: current_user,
        email: current_user.email,
        preferred_contact_method: ContactMethod.email,
      )
    end
  end

  def create_match_for_contribution
    MatchContribution.run!(contribution: contribution, match_with: current_user)
  end

  def email_peer
    EmailPeer.run!(
      contribution: contribution,
      peer_alias: peer_alias,
      message: message,
      user: current_user
    )
  end
end
