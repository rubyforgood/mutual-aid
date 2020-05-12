class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  def landing_page
    @match_count = Match.any? ? Match.pluck(:receiver_id).uniq.length : 1
    @ask_count = Ask.any? ? Ask.all.length : 1
    @percent_asks_fulfilled = ((@match_count.to_f/@ask_count.to_f).to_f * 100).to_i
    @asks_unmatched_count = Ask.unmatched.length
    @offers_unmatched_count = Offer.unmatched.length
    @announcements_pending_count = Announcement.pending_review.length
    @community_resources_pending_count = Announcement.pending_review.length
  end

  def yearbook
    @positions = Position.all
  end
end
