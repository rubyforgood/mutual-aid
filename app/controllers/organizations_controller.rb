# frozen_string_literal: true

class OrganizationsController < AdminController
  before_action :set_organization, only: %i[show edit update destroy]

  def index
    @organizations = Organization.all
  end

  def show; end

  def new
    @organization = Organization.new
  end

  def edit; end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to organizations_path, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to organizations_path, notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: 'Organization was successfully destroyed.'
  end

  def org_chart
    @organizations = Organization.org_chart
  end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(
          :description,
          :display_on_org_chart,
          :facebook_url,
          :favicon_url,
          :has_hosting_account,
          :has_mailer_account,
          :has_sms_account,
          :is_instance_owner,
          :logo_url,
          :name,
          :phone,
          :website_url,
          )
    end
end
