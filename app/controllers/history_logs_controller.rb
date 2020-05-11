class HistoryLogsController < ApplicationController

  def index
    @history_logs = HistoryLog.all
  end

end
