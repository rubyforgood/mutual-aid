class HistoryLogsController < ApplicationController
  include NotUsingPunditYet

  def index
    @history_logs = HistoryLog.all
  end

end
