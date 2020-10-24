# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def landing_page
    @submission_count = Submission.count
    @match_count = Match.any? ? Match.pluck(:receiver_id).uniq.length : 1
    @ask_count = Ask.any? ? Ask.all.length : 1
    @offer_count = Offer.any? ? Offer.all.length : 1
    @percent_offers_fulfilled = ((@match_count.to_f / @offer_count.to_f).to_f * 100).to_i
    @percent_asks_fulfilled = ((@match_count.to_f / @ask_count.to_f).to_f * 100).to_i
    @asks_unmatched_count = Ask.unmatched.length
    @offers_unmatched_count = Offer.unmatched.length
    @announcements_pending_count = Announcement.pending_review.length
    @community_resources_pending_count = CommunityResource.pending_review.length
  end

  def dispatch_steps; end

  def form_admin; end

  def glossary; end

  def yearbook
    @positions = Position.all
  end
end
