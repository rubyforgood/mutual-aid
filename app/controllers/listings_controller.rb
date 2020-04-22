class ListingsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  before_action :set_listing,    only: [:show, :destroy, :match, :match_confirm]
  before_action :set_form,       only: [:edit, :update]
  before_action :set_empty_form, only: [:new, :create]

  # GET /listings
  # GET /listings.json
  def index
    # TODO: these json strings are to be replaced with actual generators of data
    @listings_json = '[
      { "id": 1, "category_ids": [1], "timings": [1,2,3], "location": 1, "short_title":"Look after my kid", "description":"Lorem Ipsum is the name of my child"},
      { "id": 2, "category_ids": [1,2], "timings": [1,2,3], "location": 12},
      { "id": 3, "category_ids": [3], "timings": [3], "location": 1, "short_title":"bathroom help", "description":"I\'m afraid I\'ll fall and hurt my hip again. Can someone help me clean?"},
    ]'
    @categories_json = '[{"id":1, "name": "Care"}, {"id": 2, "name": "Meals"} {"id":3, "name": "Housework"}]'
    @locations_json = '[
      {"id":1, "name": "East Bay"},
      {"id":2, "name": "Kings Bay"}
    ]'
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
