class OffersController < ApplicationController

  # FIXME: pull this up into PublicController (but it currently has extra actions)
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @offer = Offer.new(listing_params)
    if @offer.save
      redirect_to root_path, notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  private

    def listing_params
      params.require(:listing).permit(
        :service_area_id,
        {
          person_attributes: [
            :email,
            :preferred_contact_method,
          ]
        },
      )
    end
end
