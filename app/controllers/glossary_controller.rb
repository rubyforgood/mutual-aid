class GlossaryController < PublicController
  include NotUsingPunditYet

  before_action :set_system_settings

  def show; end
  def edit; end

  def update
    @system_settings.update!(glossary_params)
    redirect_to glossary_path
  end

  private

  def glossary_params
    params.require(:system_setting).permit(:glossary_content)
  end

  def set_system_settings
    @system_settings = SystemSetting.current_settings
  end
end
