class CommunityResourcesController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_community_resource, only: [:show, :edit, :update, :destroy]

  def index
    @community_resources = CommunityResource.all
  end

  def show
  end

  def new
    @community_resource = CommunityResource.new
  end

  def edit
  end

  def create
    @community_resource = CommunityResource.new(community_resource_params)

    respond_to do |format|
      if @community_resource.save
        format.html { redirect_to @admin_status ? community_resources_path : community_resources_public_path, notice: "Community resource was successfully submitted.#{ " We'll review." unless @admin_status }" }
        format.json { render :show, status: :created, location: @community_resource }
      else
        format.html { render :new }
        format.json { render json: @community_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @community_resource.update(community_resource_params)
        format.html { redirect_to community_resources_path, notice: 'Community resource was successfully updated.' }
        format.json { render :index, status: :ok, location: @community_resource }
      else
        format.html { render :edit }
        format.json { render json: @community_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community_resource.destroy
    respond_to do |format|
      format.html { redirect_to community_resources_public_path, notice: 'Community resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_community_resource
      @community_resource = CommunityResource.find(params[:id])
    end

    def community_resource_params
      params.require(:community_resource).permit(
          :description,
          :facebook_url,
          :is_approved,
          :name,
          :organization_id,
          :phone,
          :publish_from,
          :publish_until,
          :service_area_id,
          :website_url,
          :youtube_identifier,
          tag_list: [])
    end
end
