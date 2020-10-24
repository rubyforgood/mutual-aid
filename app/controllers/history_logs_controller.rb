# frozen_string_literal: true

class HistoryLogsController < ApplicationController
  def index
    @history_logs = HistoryLog.all
  end
end
