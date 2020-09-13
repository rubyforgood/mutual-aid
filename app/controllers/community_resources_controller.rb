class CommunityResourcesController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_community_resource, only: [:show, :edit, :update, :destroy]

  layout :determine_layout, only: [:new, :show]

  def index
    @community_resources = CommunityResource.includes(:organization).references(:organization).order(created_at: :desc)
  end

  def show
  end

  def new
    @community_resource = CommunityResource.new
    @community_resource.build_organization
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @community_resource = CommunityResource.new(community_resource_params)

    if @community_resource.save
      redirect_to @admin_status ? community_resources_path : contribution_thank_you_path, notice: "Community resource was successfully submitted.#{ " We'll review." unless @admin_status }"
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @community_resource.update(community_resource_params)
      redirect_to community_resources_path, notice: 'Community resource was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @community_resource.destroy
    redirect_to community_resources_public_path, notice: 'Community resource was successfully destroyed.'
  end

  private
    def set_community_resource
      @community_resource = CommunityResource.find(params[:id])
    end

    def set_form_dropdowns
      @available_tags = Category.visible.pluck(:name) + @community_resource&.tag_list || []
    end

    def determine_layout
      "without_navbar" unless @system_setting.display_navbar?
    end

    def community_resource_params
      params.require(:community_resource).permit(
          :description,
          :facebook_url,
          :is_approved,
          :name,
          :phone,
          :publish_from,
          :publish_until,
          :service_area_id,
          :website_url,
          :youtube_identifier,
          tag_list: [],
          organization_attributes: [ :id, :name, :_destroy ]
          )
    end
end
