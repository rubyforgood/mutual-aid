class ExternalResourcesController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_external_resource, only: [:show, :edit, :update, :destroy]

  def index
    @external_resources = ExternalResource.all
  end

  def show
  end

  def new
    @external_resource = ExternalResource.new
  end

  def edit
  end

  def create
    @external_resource = ExternalResource.new(external_resource_params)

    respond_to do |format|
      if @external_resource.save
        format.html { redirect_to @admin_status ? external_resources_path : community_resources_path, notice: "External resource was successfully submitted.#{ " We'll review." unless @admin_status }" }
        format.json { render :show, status: :created, location: @external_resource }
      else
        format.html { render :new }
        format.json { render json: @external_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @external_resource.update(external_resource_params)
        format.html { redirect_to community_resources_path, notice: 'External resource was successfully updated.' }
        format.json { render :index, status: :ok, location: @external_resource }
      else
        format.html { render :edit }
        format.json { render json: @external_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @external_resource.destroy
    respond_to do |format|
      format.html { redirect_to community_resources_path, notice: 'External resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_resource
      @external_resource = ExternalResource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def external_resource_params
      params.require(:external_resource).permit(
          :description,
          :publish_until,
          :publish_from,
          :facebook_url,
          :location_id,
          :name,
          :phone,
          :approved,
          :website_url,
          :youtube_identifier,
          tags: [])
    end
end
