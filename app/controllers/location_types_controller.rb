# frozen_string_literal: true

class LocationTypesController < AdminController
  before_action :set_location_type, only: %i[show edit update destroy]

  def index
    @location_types = LocationType.all
  end

  def show; end

  def new
    @location_type = LocationType.new
  end

  def edit; end

  def create
    @location_type = LocationType.new(location_type_params)

    if @location_type.save
      redirect_to location_types_path, notice: 'Location type was successfully created.'
    else
      render :new
    end
  end

  def update
    if @location_type.update(location_type_params)
      redirect_to location_types_path, notice: 'Location type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @location_type.destroy
    redirect_to location_types_url, notice: 'Location type was successfully destroyed.'
  end

  private

    def set_location_type
      @location_type = LocationType.find(params[:id])
    end

    def location_type_params
      params.require(:location_type).permit(:name, :description, :display_to_public)
    end
end
