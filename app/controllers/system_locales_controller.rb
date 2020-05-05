class SystemLocalesController < ApplicationController
  before_action :set_system_locale, only: [:show, :edit, :update, :destroy]

  def index
    @system_locales = SystemLocale.order(:locale_name)
  end

  def show
  end

  def new
    @system_locale = SystemLocale.new
  end

  def edit
  end

  def create
    @system_locale = SystemLocale.new(system_locale_params)

    respond_to do |format|
      if @system_locale.save
        format.html { redirect_to @system_locale, notice: 'System locale was successfully created.' }
        format.json { render :show, status: :created, location: @system_locale }
      else
        format.html { render :new }
        format.json { render json: @system_locale.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @system_locale.update(system_locale_params)
        format.html { redirect_to @system_locale, notice: 'System locale was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_locale }
      else
        format.html { render :edit }
        format.json { render json: @system_locale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @system_locale.destroy
    respond_to do |format|
      format.html { redirect_to system_locales_url, notice: 'System locale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_system_locale
      @system_locale = SystemLocale.find(params[:id])
    end

    def system_locale_params
      params.require(:system_locale).permit(:locale, :locale_name, :publish_in_dropdowns, :publish_translations)
    end
end
