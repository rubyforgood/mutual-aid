# frozen_string_literal: true

class CommunityResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new create]

  def index
    @community_resources = policy_scope(CommunityResource).includes(:organization).order(created_at: :desc)
  end

  def show; end
  def edit; end

  def new
    community_resource.build_organization
  end

  def create
    @community_resource = authorize populate(CommunityResource.new)
    if @community_resource.save
      redirect_after_create
    else
      render :new
    end
  end

  def update
    @community_resource = authorize populate(CommunityResource.find(params[:id]))
    if @community_resource.save
      redirect_to community_resources_path, notice: 'Community resource was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    community_resource.destroy!
    redirect_to community_resources_path, notice: 'Community resource was successfully destroyed.'
  end

  private

  def populate(community_resource)
    CommunityResourceForm.build permitted_attributes(community_resource).merge(id: params[:id])
  end

  def community_resource
    @community_resource ||= authorize CommunityResource.find_or_new params[:id]
  end

  def available_tags
    @available_tags ||= Category.visible.pluck(:name) + community_resource&.tag_list || []
  end

  def service_areas
    @service_areas ||= ServiceArea.i18n.pluck(:name, :id) || []
  end

 

  def redirect_after_create
    notice = "Community resource was successfully submitted."
    if context.can_admin?
      redirect_to community_resources_path, notice: notice
    else
      redirect_to thank_you_path, notice: "#{notice} We'll review."
    end
  end

  helper_method :available_tags, :community_resource, :service_areas
end
