class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :match, :match_confirm]
  CONTRIBUTION_MODELS = [Listing]

  def index
    @filter_types = FilterTypeBlueprint.render([Category, ServiceArea])
    @contributions = ContributionBlueprint.render(contributions_for(filter_params))
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def show
  end

  def new
    @listing = Listing.new
    set_form_dropdowns
  end

  def match
    listing_type = @listing.type
    match_polymorphic_params = listing_type == Ask ? { receiver: @listing } : { provider: @listing }
    @match = Match.new
    @match.update(match_polymorphic_params)
    @possible_providers = Listing.offers # TODO - get this to be a filtered list -- need to add logic by which to match
  end

  def match_confirm
    @match = Match.first # TODO - implement match id here
  end

  def edit
    set_form_dropdowns
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to listings_path, notice: 'Listing was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @listing.save
      redirect_to listings_path, notice: 'Listing was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully destroyed.'
  end

  private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_form_dropdowns
      @available_tags = Category.visible.pluck(:name) + @listing&.tag_list || []
    end

    def listing_params
      params.require(:listing).permit(
        :description,
        :location_id,
        :person_id,
        :service_area_id,
        :state,
        :title,
        :type,
        tags: [],
      )
    end

    def filter_params
      params.permit('Category' => {}, 'ServiceArea' => {}).to_h.each_with_object({}) do |(model_name, id_hash), data|
        data[model_name.underscore] = id_hash.keys
      end
    end

    def contributions_for(parameters)
      CONTRIBUTION_MODELS.map { |model| model.filter_by(parameters) }.flatten
    end
end
