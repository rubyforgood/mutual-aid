class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = Organization.all
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

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
          :name, :description, :display_on_org_chart, :facebook_url, :website_url, :phone, :is_instance_owner,
          :has_sms_account, :has_hosting_account, :has_mailer_account)
    end
end
