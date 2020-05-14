class DonationsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  def index
    @donations = Donation.all
  end

  def show
  end

  def new
    @donation = Donation.new
    @donation.build_person
  end

  def edit
  end

  def create
    @donation = Donation.new(donation_params)

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @admin_status ? donations_path : root_path, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to donations_path, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(
          :value,
          :channel,
          :thank_you_sent,
          :notes,
          person_attributes: [ :id, :preferred_contact_method_id, :name, :email, :phone, :_destroy]
      )
    end
end
