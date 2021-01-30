class GlossaryController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :authorize_glossary
  before_action :set_system_settings

  def show; end
  def edit; end

  def update
    @system_settings.update!(glossary_params)
    redirect_to glossary_path
  end

  private

  def authorize_glossary
    authorize :glossary
  end

  def glossary_params
    params.require(:system_setting).permit(:glossary_content)
  end

  def set_system_settings
    @system_settings = SystemSetting.current_settings
  end
end
