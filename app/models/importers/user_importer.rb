# frozen_string_literal: true

class Importers::UserImporter < Importers::BaseImporter
  def initialize(current_user, create_users_if_possible=true)
    require "#{Rails.root}/db/scripts/tuple_counts.rb"
    audit_info(current_user)
    set_klasses
    establish_counts

    @current_user = current_user
    @create_users_if_possible = create_users_if_possible
  end

  def klasses_array
    [Person,User]
  end

  def required_fields_array
    []
  end

  def primary_import_klass_name
    'User'
  end

  def is_row_header(row)
    ['timestamp'].include?(row['Timestamp']&.downcase) || ['name'].include?(row['name']&.downcase)
  end

  def find_or_create_user_from_row(row, skip_create: false)
    user = nil
    users = User.where(email: row['email'], confirmed_at: parse_date(row['confirmed_at']) || Time.now)
    if !skip_create && @create_users_if_possible
      user = users.first_or_create!(password: row['password'] || '[CHANGEMENOW]')
    end
    user ||= users.last
  end

  def process_row(row)
    user = find_or_create_user_from_row(row, skip_create: true)
    if user.present?
      log = 'GOT DUPE'
      puts "#{log} User --------#{history_log_name(row)}"
      @dupe_records_count += 1
    else
      @new_records_count += 1
      user = find_or_create_user_from_row(row, skip_create: false)
    end
    user
  end

  def history_log_name(row)
    ' +++ user email: ' + row['email'].to_s
  end
end
