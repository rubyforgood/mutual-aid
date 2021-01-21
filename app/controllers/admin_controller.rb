# frozen_string_literal: true

class AdminController < ApplicationController
  include NotUsingPunditYet

  before_action :authenticate_user!, except: %i[new create]
  before_action :set_system_settings, only: [:glossary_edit, :glossary_index, :glossary_update]

  def dispatch_steps; end

  # FIXME: extract glossary related code into their own controller
  def glossary_edit
    @system_settings = SystemSetting.current_settings
    render 'admin/glossary/form'
  end

  def glossary_index
    @glossary_content = @system_settings.glossary_content
    render 'admin/glossary/index'
  end

  def glossary_update
    @system_settings.update(glossary_content: glossary_params[:glossary_content])
    redirect_to glossary_admin_path
  end

  def yearbook
    @positions = Position.all
  end

  private

  def glossary_params
    params.require(:system_setting).permit(:glossary_content)
  end

  def set_system_settings
    @system_settings = SystemSetting.current_settings
  end
end
