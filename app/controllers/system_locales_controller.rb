# frozen_string_literal: true

class SystemLocalesController < AdminController
  before_action :set_system_locale, only: %i[show edit update destroy]

  def index
    @system_locales = SystemLocale.order(:locale_name)
  end

  def show; end

  def new
    @system_locale = SystemLocale.new
  end

  def edit; end

  def create
    @system_locale = SystemLocale.new(system_locale_params)

    if @system_locale.save
      redirect_to system_locales_path, notice: 'System locale was successfully created.'
    else
      render :new
    end
  end

  def update
    if @system_locale.update(system_locale_params)
      redirect_to system_locales_path, notice: 'System locale was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @system_locale.destroy
    redirect_to system_locales_url, notice: 'System locale was successfully destroyed.'
  end

  private

    def set_system_locale
      @system_locale = SystemLocale.find(params[:id])
    end

    def system_locale_params
      params.require(:system_locale).permit(:locale, :locale_name, :publish_in_dropdowns, :publish_translations)
    end
end
