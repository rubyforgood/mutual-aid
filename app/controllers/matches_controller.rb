class MatchesController < ApplicationController
  before_action :set_match, only: [:edit, :update, :destroy]

  def index
    @matches = Match.status(params[:status] || "all").order(updated_at: :desc)
    @statuses = ["all"] + Match::STATUSES
  end

  def show
    @match = Match.includes(:communication_logs).references(:communication_logs).where(id: params[:id]).last
  end

  def new
    @match = Match.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      if params[:commit]&.include?('Save and View Match')
        redirect_to match_path(@match),
                    notice: 'Match was successfully created.'
      else
        redirect_to matches_path,
                    notice: 'Match was successfully created.'
      end
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @match.update(match_params)
      if params[:commit]&.include?('Save and View Match')
        redirect_to match_path(@match),
                    notice: 'Match was successfully updated.'
      else
        redirect_to matches_path,
                    notice: 'Match was successfully updated.'
      end
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @match.destroy
    redirect_to matches_url, notice: 'Match was successfully destroyed.'
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def set_form_dropdowns
      type = params["receiver_id"].present? ? "Ask" : "Offer" # TODO change w resources
      if type == "Ask"
        @receiver = Listing.where(type: type, id: params[:receiver_id]).first
      elsif type == "Offer"
        @provider = Listing.where(type: type, id: params[:provider_id]).first
      end

      if @match.receiver_id && @match.provider_id
        @matched_asks = Ask.matched.map{ |a| [ a.name_and_contact_info.html_safe, a.id ] }.sort_by(&:first)
        @matched_offers = Offer.matched.map{ |o| [ o.name_and_contact_info.html_safe, o.id] }.sort_by(&:first)
      else
        @unmatched_asks = Ask.unmatched.map{ |a| [ a.name_and_contact_info.html_safe, a.id ] }.sort_by(&:first)
        @unmatched_offers = Offer.unmatched.map{ |o| [ o.name_and_contact_info.html_safe, o.id] }.sort_by(&:first)
      end
      @statuses = Match::STATUSES
    end

    def match_params
      params.require(:match).permit(
          :receiver_id,
          :provider_id,
          :shift_id,
          :receiver_type,
          :provider_type,
          :status,
          :notes,
          :tentative,
          :completed)
    end
end
