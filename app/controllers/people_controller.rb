class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all
  end

  def show
  end

  def new
    @person = Person.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        set_form_dropdowns
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_path, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        set_form_dropdowns
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def set_form_dropdowns
      @system_locales = SystemLocale.where(publish_in_dropdowns: true).pluck(:locale_name, :id)
      @preferred_contact_methods = ContactMethod.enabled
      @preferred_locale_id = SystemLocale.where(locale: @person.preferred_locale).first&.id
    end

    def person_params
      params.require(:person).permit(
          :name,
          :phone,
          :email,
          :phone_2,
          :email_2,
          :skills,
          :monthly_matches_max,
          :monthly_donation_amount_max,
          :notes,
          :user_id,
          :location_id,
          :service_area_id,
          :preferred_locale,
          :preferred_contact_timeframe,
          :preferred_contact_method_id)
    end
end
