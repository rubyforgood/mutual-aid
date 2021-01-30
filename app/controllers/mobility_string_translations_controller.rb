# frozen_string_literal: true

class MobilityStringTranslationsController < AdminController
  before_action :set_mobility_string_translation, only: %i[show edit update destroy]

  def index
    @mobility_string_translations = MobilityStringTranslation.all
  end

  def show; end

  def new
    @mobility_string_translation = MobilityStringTranslation.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @mobility_string_translation = MobilityStringTranslation.new(mobility_string_translation_params)

    if @mobility_string_translation.save
      redirect_to mobility_string_translations_path, notice: 'Mobility string translation was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @mobility_string_translation.update(mobility_string_translation_params)
      redirect_to mobility_string_translations_path, notice: 'Mobility string translation was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @mobility_string_translation.destroy
    redirect_to mobility_string_translations_url, notice: 'Mobility string translation was successfully destroyed.'
  end

  private

    def set_mobility_string_translation
      @mobility_string_translation = MobilityStringTranslation.find(params[:id])
    end

    def set_form_dropdowns
      @system_locales = SystemLocale.where(publish_in_dropdowns: true).pluck(:locale_name, :locale)
    end

    def mobility_string_translation_params
      params.require(:mobility_string_translation).permit(
        :translatable_type,
        :translatable_id,
        :locale,
        :key,
        :value,
        :created_by_id,
        :is_approved)
    end
end
