class AddStandingMeetingScheduleToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :standing_meeting_schedule, :string
  end
end
