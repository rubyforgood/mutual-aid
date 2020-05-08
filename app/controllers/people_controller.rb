class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all
  end

  def show
  end

  def new
    @person = Person.new
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
      @preferred_contact_methods = Person::PREFERRED_CONTACT_METHODS
    end

    def person_params
      params.require(:person).permit(:first_name,
                                     :last_name,
                                     :phone,
                                     :email,
                                     :phone_2,
                                     :email_2,
                                     :skills,
                                     :notes,
                                     :user_id,
                                     :preferred_locale,
                                     :preferred_contact_timeframe,
                                     :preferred_contact_method)
    end
end
