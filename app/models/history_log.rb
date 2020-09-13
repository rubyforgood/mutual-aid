class HistoryLog < ApplicationRecord

  validates :name, presence: true

  # TODO enable this to track Listing edits
  # def self.generate_record_log!(record, current_user, log_type="UPDATED", extra_detail=nil)
  #   current_user ||= User.first
  #   klass = record.class
  #
  #   self.create!(name: record.try(:name) + " +++ " + record.inspect + " +++ " + extra_detail.to_s + " +++ " +
  #       "#{log_type} BY: #{current_user&.name}",
  #                topic: "#{klass.name} #{log_type}")
  # end

  def self.generate_import_log!(current_user, import_klass, extra_detail=nil)
    self.create!(name: extra_detail + " +++ " + "IMPORTED BY: #{current_user&.name}",
                 topic: "#{import_klass.name} IMPORTED")
  end
end

# == Schema Information
#
# Table name: history_logs
#
#  id         :bigint           not null, primary key
#  name       :string
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
