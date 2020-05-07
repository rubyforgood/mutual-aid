class MobilityStringTranslationsController < ApplicationController
  def index
    @mobility_string_translations = MobilityStringTranslation.all
  end
end
