# frozen_string_literal: true

class MatchContribution < ActiveInteraction::Base
  object :contribution, class: Listing
  object :match_with, class: User

  def execute
    Match.create! match_receiver_and_provider.merge(status: 'match_confirmed')
    contribution.matched!
  end

  private

  def match_receiver_and_provider
    if contribution.ask?
      { receiver: contribution, provider: Offer.create!(counter_contribution_params) }
    elsif contribution.offer?
      { receiver: Ask.create!(counter_contribution_params), provider: contribution }
    else
      # TODO: check if community resource type when it's added
      raise "Unhandled contribution type: #{contribution.type}"
    end
  end

  def counter_contribution_params
    { person: person, service_area: contribution.service_area }
  end

  def person
    match_with.person
  end
end
