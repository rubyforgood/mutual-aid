class OffersController < ApplicationController

  # FIXME: pull this up into PublicController (but it currently has extra actions)
  skip_before_action :authenticate_user!

  def new
    serialize(Offer.new)
  end

  def create
    outcome = SaveListing.run(params[:listing])
    if outcome.valid?
      redirect_to root_path, notice: 'Offer was successfully created.'
    else
      serialize(outcome)
      render :new
    end
  end

  private

    def serialize(object)
      @offer_json = ListingBlueprint.render object, view: :normal
    end
end
