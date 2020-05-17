class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to locations_path, notice: 'Location was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @location.update(location_params)
      redirect_to locations_path, notice: 'Location was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path, notice: 'Location was successfully destroyed.'
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def set_form_dropdowns
    @service_areas = ServiceArea.all.map{ |t| [t.full_name, t.id] }.sort_by(&:first)
  end

  def location_params
    params.require(:location).permit(
        :location_type_id,
        :street_address,
        :city,
        :state,
        :zip,
        :county,
        :region,
        :neighborhood)
  end
end
