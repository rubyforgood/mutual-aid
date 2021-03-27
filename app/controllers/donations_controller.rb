# frozen_string_literal: true

class DonationsController < AdminController
  before_action :authenticate_user!, except: %i[new create]
  before_action :set_donation, only: %i[show edit update destroy]

  def index
    @donations = Donation.all
  end

  def show; end

  def new
    set_form_dropdowns
    @donation = Donation.new
    @donation.build_person
  end

  def edit
    set_form_dropdowns
  end

  def create
    @donation = Donation.new(donation_params)

    if @donation.save
      redirect_to @admin_status ? donations_path : thank_you_path, notice: 'Donation was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @donation.update(donation_params)
      redirect_to donations_path, notice: 'Donation was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @donation.destroy
    redirect_to donations_url, notice: 'Donation was successfully destroyed.'
  end

  private

    def set_donation
      @donation = Donation.find(params[:id])
    end

    def set_form_dropdowns
      @contact_methods = ContactMethod.enabled
    end

    def donation_params
      params.require(:donation).permit(
          :value,
          :channel,
          :thank_you_sent,
          :notes,
          person_attributes: %i[id preferred_contact_method_id name email phone _destroy]
      )
    end
end
