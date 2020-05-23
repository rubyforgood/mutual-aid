class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :match, :match_confirm]

  def index
    @filter_types = FilterTypeBlueprint.render([ContributionType, Category, ServiceArea, UrgencyLevel, ContactMethod])
    filter = BrowseFilter.new(filter_params, self)
    @contributions = ContributionBlueprint.render(filter.contributions, **filter.options)
    respond_to do |format|
      format.html
      format.json { render inline: @contributions }
    end
  end

  def listings_index
    @listings = Listing.all
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

  def show
  end

  def new
    @listing = Listing.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to contribution_thank_you_path, notice: 'Listing was successfully created.'
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
        :submission_id,
        :title,
        :type,
        tag_list: [],
      )
    end

    def allowed_params
      @allowed_params ||= params.permit(:format, **BrowseFilter::ALLOWED_PARAMS)
    end

    def filter_params
      return Hash.new unless allowed_params && allowed_params.to_h.any?
      allowed_params.to_h.filter { |key, _v| BrowseFilter::ALLOWED_PARAMS.keys.include? key}.tap do |hash|
        hash.keys.each { |key| hash[key] = hash[key].keys}
      end
    end
end
