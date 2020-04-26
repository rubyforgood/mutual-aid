class SystemLocationsController < ApplicationController
  before_action :set_system_location, only: [:show, :edit, :update, :destroy]

  def index
    @system_locations = SystemLocation.all
  end

  def show
  end

  def new
    @system_location = SystemLocation.new
  end

  def edit
  end

  def create
    @system_location = SystemLocation.new(system_location_params)

    respond_to do |format|
      if @system_location.save
        format.html { redirect_to system_locations_path, notice: 'System location was successfully created.' }
        format.json { render :show, status: :created, location: @system_location }
      else
        format.html { render :new }
        format.json { render json: @system_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @system_location.update(system_location_params)
        format.html { redirect_to system_locations_path, notice: 'System location was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_location }
      else
        format.html { render :edit }
        format.json { render json: @system_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @system_location.destroy
    respond_to do |format|
      format.html { redirect_to system_locations_url, notice: 'System location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_system_location
      @system_location = SystemLocation.find(params[:id])
    end

    def system_location_params
      params.require(:system_location).permit(:parent_id, :organization_id, :location_type, :street_address, :city, :state, :zip, :county, :region, :neighborhood, system_locations_attributes: [])
    end
end
