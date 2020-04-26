class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new
    @parent_locations = Location.order(:name).map{ |t| [t.full_name, t.id] }
  end

  def edit
    @parent_locations = Location.order(:name).map{ |t| [t.full_name, t.id] }
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        @parent_locations = Location.order(:name).map{ |t| [t.full_name, t.id] }
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to locations_path, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_path, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(
        :name,
        :description,
        :display_to_public,
        :display_order,
        :parent_id,
        :created_by,
        :neighborhood,
        :region,
        locations_attributes: [])
  end
end
