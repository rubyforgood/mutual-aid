class OffersController < ApplicationController

  # FIXME: pull this up into PublicController (but it currently has extra actions)
  skip_before_action :authenticate_user!

  def new
    serialize(Offer.new)
  end

  def create
    outcome = SaveListing.run params_with_defaults
    if outcome.valid?
      redirect_to root_path, notice: 'Offer was successfully created.'
    else
      serialize(outcome)
      render :new
    end
  end

  private

    def params_with_defaults
      params[:listing].merge(
        type: 'Offer',
        title: '',
        description: '',
      )
    end

    def serialize(offer_or_outcome)
      @json = {
        offer: ListingBlueprint.render_as_hash(offer_or_outcome, view: :normal),
        contact_methods: ContactMethodBlueprint.render_as_hash(ContactMethod.enabled),
        service_areas: ServiceAreaBlueprint.render_as_hash(ServiceArea.all),
      }.to_json
    end
end
