class AsksController < PublicController

  def index
    redirect_to contributions_public_path
  end

  def new
    serialize(Ask.new)
  end

  def create
    outcome = SaveListing.run params[:listing].merge(type: 'Ask')
    if outcome.valid?
      redirect_to submission_thank_you_path, notice: 'Ask was successfully created.'
    else
      serialize(outcome)
      render :new
    end
  end

  def update # for rails-side edits
    @listing = Listing.find(params[:id])
    if @listing.save
      redirect_to listings_path, notice: 'Listing was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  private

    def serialize(ask_or_outcome)
      @json = {
        ask: ListingBlueprint.render_as_hash(ask_or_outcome, view: :normal),
        categories: CategoryBlueprint.render_as_hash(Category.visible.roots, view: :normal),
        contact_methods: ContactMethodBlueprint.render_as_hash(ContactMethod.enabled),
        service_areas: ServiceAreaBlueprint.render_as_hash(ServiceArea.all),
      }.to_json
    end
end
