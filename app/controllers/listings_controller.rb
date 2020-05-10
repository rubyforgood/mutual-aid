class ListingsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  before_action :set_listing,    only: [:show, :destroy, :match, :match_confirm]
  before_action :set_form,       only: [:edit, :update]
  before_action :set_empty_form, only: [:new, :create]

  # GET /listings
  # GET /listings.json
  def index
    # TODO: these json fixtures are to be replaced with actual generators of data
    sample_data = File.open('lib/listings.json') do |file|
      JSON.load(file)
    end
    sample_filter_categories = File.open('lib/filterCategories.json') do |file|
      JSON.load(file)
    end
    @contributions = sample_data["contributions"]
    @filter_categories = sample_filter_categories
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  def new
  end

  def match
    @match = Match.new(asker: @listing)
    @possible_owners = Listing.all # TODO - get this to be a filtered list -- need to add logic by which to match
  end

  def match_confirm
    @match = Match.first # TODO - implement match id here
  end

  def edit
  end

  def create
    if @listing.validate(params[:listing])
      @listing.save
      redirect_to root_path, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  def update
    if @listing.validate(params[:listing])
      @listing.save
      redirect_to listings_path, notice: 'Listing was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_form
      @listing = ListingForm.new(Listing.find(params[:id]))
    end

    def set_empty_form
      @listing = ListingForm.new(Listing.new(location: Location.new))
    end
end
