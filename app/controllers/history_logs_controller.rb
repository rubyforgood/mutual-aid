# frozen_string_literal: true

class HistoryLogsController < ApplicationController
  include NotUsingPunditYet

  def index
    @history_logs = HistoryLog.all
  end
end
