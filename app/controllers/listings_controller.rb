class ListingsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  before_action :set_listing,    only: [:show, :destroy]
  before_action :set_form,       only: [:edit, :update]
  before_action :set_empty_form, only: [:new, :create]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  def new
  end

  def edit
  end

  def create
    if @listing.validate(params[:listing])
      @listing.save
      redirect_to @listing, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  def update
    if @listing.validate(params[:listing])
      @listing.save
      redirect_to @listing, notice: 'Listing was successfully updated.'
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
