class CommunicationLogsController < ApplicationController
  before_action :set_communication_log, only: [:show, :edit, :update, :destroy]

  def index
    @communication_logs = CommunicationLog.includes(:delivery_method, :person).
        references(:delivery_method, :person).order(sent_at: :desc)
  end

  def show
  end

  def new
    @communication_log = CommunicationLog.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @communication_log = CommunicationLog.new(communication_log_params)

    if @communication_log.save
      if params[:commit]&.include?('Save and go to Match')
        redirect_to edit_match_path(@communication_log.match), notice: 'Communication log was successfully created.'
      else
        redirect_to communication_logs_path, notice: 'Communication log was successfully created.'
      end
    else
      set_form_dropdowns
      render :new
    end
  end

  def create_remote
    @communication_log = CommunicationLog.new(communication_log_params)

    if @communication_log.save
      render @communication_log, layout: false
    else
      render :new
    end
  end

  def update
    if @communication_log.update(communication_log_params)
      if params[:commit]&.include?('Save and go to Match')
        redirect_to edit_match_path(@communication_log.match), notice: 'Communication log was successfully updated.'
      else
        redirect_to communication_logs_path, notice: 'Communication log was successfully updated.'
      end
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @communication_log.destroy
    redirect_to communication_logs_url, notice: 'Communication log was successfully destroyed.'
  end

  private
    def set_communication_log
      @communication_log = CommunicationLog.find(params[:id])
    end

    def set_form_dropdowns
      @delivery_method_id = ContactMethod.where("LOWER(name) = ?", params[:delivery_method_name].downcase).last&.id if params[:delivery_method_name].present?
    end

    def communication_log_params
      params.require(:communication_log).permit(
          :person_id,
          :match_id,
          :body,
          :created_by_id,
          :delivery_method_id,
          :delivery_status,
          :needs_follow_up,
          :outbound,
          :sent_at,
          :subject,
      )
    end
end
