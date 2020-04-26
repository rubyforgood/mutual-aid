class CommunicationLogsController < ApplicationController
  before_action :set_communication_log, only: [:show, :edit, :update, :destroy]

  def index
    @communication_logs = CommunicationLog.all
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

    respond_to do |format|
      if @communication_log.save
        format.html { redirect_to communication_logs_path, notice: 'Communication log was successfully created.' }
        format.json { render :show, status: :created, location: @communication_log }
      else
        format.html { render :new }
        format.json { render json: @communication_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @communication_log.update(communication_log_params)
        format.html { redirect_to communication_logs_path, notice: 'Communication log was successfully updated.' }
        format.json { render :show, status: :ok, location: @communication_log }
      else
        format.html { render :edit }
        format.json { render json: @communication_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @communication_log.destroy
    respond_to do |format|
      format.html { redirect_to communication_logs_url, notice: 'Communication log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_communication_log
      @communication_log = CommunicationLog.find(params[:id])
    end

    def communication_log_params
      params.require(:communication_log).permit(:person_id, :channel, :sent_at, :needs_follow_up)
    end
end
