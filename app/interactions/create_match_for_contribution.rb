# frozen_string_literal: true

class CreateMatchForContribution < ActiveInteraction::Base
  object :contribution, class: Listing
  object :match_with, class: User

  def execute
    create_match_for_contribution!
    contribution.matched!
  end

  private

  def create_match_for_contribution!
    match_params = if contribution.ask?
                      { receiver: contribution, provider: create_offer_for_ask! }
                    elsif contribution.offer? # TODO: check if community resource type when it's added
                      { receiver: create_ask_for_offer!, provider: contribution }
                    end
    Match.create!(match_params.merge(status: 'match_confirmed'))
  end

  def create_offer_for_ask!
    Offer.create!(counter_contribution_params)
  end

  def create_ask_for_offer!
    Ask.create!(counter_contribution_params)
  end

  def counter_contribution_params
    { person: person, service_area: contribution.service_area }
  end

  def person
    match_with.person
  end
end
