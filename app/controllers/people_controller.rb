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

    if @person.save
      redirect_to people_path, notice: 'Person was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @person.update(person_params)
      redirect_to people_path, notice: 'Person was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def set_form_dropdowns
      @preferred_contact_methods = ContactMethod.enabled_public
      enabled_locales = SystemLocale.where(publish_in_dropdowns: true)
      @system_locales = enabled_locales.pluck(:locale_name, :locale)
      @preferred_locale = enabled_locales.where(locale: @person.preferred_locale).first&.locale
      @preferred_contact_timeframes = [["Morning", "AM"], ["Afternoon", "PM"], ["Evening", "EVE"]]
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
