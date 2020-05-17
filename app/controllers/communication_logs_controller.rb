class CommunicationLogsController < ApplicationController
  before_action :set_communication_log, only: [:show, :edit, :update, :destroy]

  def index
    @communication_logs = CommunicationLog.includes(:delivery_method, :person).
        references(:delivery_method, :person).order(created_at: :desc)
  end

  def show
  end

  def new
    @communication_log = CommunicationLog.new
  end

  def edit
  end

  def create
    @communication_log = CommunicationLog.new(communication_log_params)

    if @communication_log.save
      redirect_to communication_logs_path, notice: 'Communication log was successfully created.'
    else
      render :new
    end
  end

  def update
    if @communication_log.update(communication_log_params)
      redirect_to communication_logs_path, notice: 'Communication log was successfully updated.'
    else
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
