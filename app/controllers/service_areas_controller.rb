# frozen_string_literal: true

class ServiceAreasController < AdminController
  before_action :set_service_area, only: %i[show edit update destroy]

  def index
    @service_areas = ServiceArea.order_by_translated_name(@system_locale&.locale)
  end

  def show; end

  def new
    set_form_dropdowns
    location_type = LocationType.where(name: LocationType::SERVICE_AREA_TYPE).first_or_create!
    location = Location.new(location_type: location_type)
    @service_area = ServiceArea.new
    @service_area.location = location
  end

  def edit
    set_form_dropdowns
  end

  def create
    @service_area = ServiceArea.new(service_area_params)

    if @service_area.save
      redirect_to service_areas_path, notice: 'ServiceArea was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @service_area.update(service_area_params)
      redirect_to service_areas_path, notice: 'ServiceArea was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @service_area.destroy
    redirect_to service_areas_url, notice: 'ServiceArea was successfully destroyed.'
  end

  private

    def set_service_area
      @service_area = ServiceArea.find(params[:id])
    end

    def set_form_dropdowns
      @service_area_location_type = LocationType.where(name: LocationType::SERVICE_AREA_TYPE).first_or_create!
      @service_area_types = ServiceArea::TYPES.map{ |i| [i,i] }
    end

    def service_area_params
      params.require(:service_area).permit(
          :parent_id,
          :organization_id,
          :service_area_type,
          :name,
          :description,
          location_attributes: %i[id
                                      location_type_id
                                      street_address
                                      city
                                      state
                                      zip
                                      county
                                      region
                                      neighborhood
                                      _destroy],
          service_areas_attributes: %i[id
                                      location_id
                                      parent_id
                                      organization_id
                                      service_area_type
                                      name
                                      description
                                      _destroy]
      )
    end
end
