class OffersController < PublicController

  def index
    redirect_to contributions_path
  end

  def new
    serialize(Offer.new)
  end

  def create
    outcome = SaveListing.run params[:listing].merge(type: 'Offer')

    if outcome.valid?
      redirect_to contribution_thank_you_path, notice: 'Offer was successfully created.'
    else
      serialize(outcome)
      render :new
    end
  end

  private

    def serialize(offer_or_outcome)
      @json = {
        offer: ListingBlueprint.render_as_hash(offer_or_outcome, view: :normal),
        categories: CategoryBlueprint.render_as_hash(Category.visible.roots, view: :normal),
        contact_methods: ContactMethodBlueprint.render_as_hash(ContactMethod.enabled),
        service_areas: ServiceAreaBlueprint.render_as_hash(ServiceArea.all),
      }.to_json
    end
end
