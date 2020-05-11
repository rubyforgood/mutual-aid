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
      redirect_to root_path, notice: 'Ask was successfully created.'
    else
      serialize(outcome)
      render :new
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
