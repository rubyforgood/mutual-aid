class CommunicationLogsController < ApplicationController
  before_action :set_communication_log, only: [:show, :edit, :update, :destroy]

  # GET /communication_logs
  # GET /communication_logs.json
  def index
    @communication_logs = CommunicationLog.all
  end

  # GET /communication_logs/1
  # GET /communication_logs/1.json
  def show
  end

  # GET /communication_logs/new
  def new
    @communication_log = CommunicationLog.new
  end

  # GET /communication_logs/1/edit
  def edit
  end

  # POST /communication_logs
  # POST /communication_logs.json
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

  # PATCH/PUT /communication_logs/1
  # PATCH/PUT /communication_logs/1.json
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

  # DELETE /communication_logs/1
  # DELETE /communication_logs/1.json
  def destroy
    @communication_log.destroy
    respond_to do |format|
      format.html { redirect_to communication_logs_url, notice: 'Communication log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_communication_log
      @communication_log = CommunicationLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def communication_log_params
      params.require(:communication_log).permit(:person_id, :channel, :sent_at, :needs_follow_up)
    end
end
