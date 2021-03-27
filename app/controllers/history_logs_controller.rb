# frozen_string_literal: true

class HistoryLogsController < AdminController
  def index
    @history_logs = HistoryLog.all
  end
end
