# frozen_string_literal: true

class CommunityResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new create]

  layout :determine_layout, only: %i[new show]

  def index
    @community_resources = policy_scope(CommunityResource).includes(:organization).order(created_at: :desc)
  end

  def show; end
  def edit; end

  def new
    community_resource.build_organization
  end

  def create
    community_resource.assign_attributes permitted_attributes(community_resource)

    if community_resource.save
      redirect_after_create
    else
      render :new
    end
  end

  def update
    if community_resource.update(permitted_attributes(community_resource))
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

    def community_resource
      @community_resource ||= authorize(params[:id] ? CommunityResource.find(params[:id]) : CommunityResource.new)
    end

    def available_tags
      @available_tags ||= Category.visible.pluck(:name) + community_resource&.tag_list || []
    end

    def determine_layout
      'without_navbar' unless context.system_settings.display_navbar?
    end

    def redirect_after_create
      notice = "Community resource was successfully submitted."
      if context.can_admin?
        redirect_to community_resources_path, notice: notice
      else
        redirect_to thank_you_path, notice: "#{notice} We'll review."
      end
    end

    helper_method :available_tags, :community_resource
end
