class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  def index
    @matches = Match.order(updated_at: :desc)
  end

  def show
  end

  def new
    @match = Match.new
    set_form_dropdowns
  end

  def edit
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to matches_path, notice: 'Match was successfully created.'
    else
      render :new
    end
  end

  def update
    if @match.update(match_params)
      redirect_to matches_path, notice: 'Match was successfully updated.'
    else
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
    end

    def match_params
      params.require(:match).permit(
          :receiver_id,
          :provider_id,
          :receiver_type,
          :provider_type,
          :status,
          :notes,
          :tentative,
          :completed)
    end
end
