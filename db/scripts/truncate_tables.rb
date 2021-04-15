# run from the command line with:  rails runner  -e development db/seeds/truncate_tables.rb

puts "------------BEGIN DELETE-------------------"

connection = ActiveRecord::Base.connection

def truncate_table(table_name, connection)
  sql = "SELECT COUNT(*) FROM #{table_name}"
  initial_count = connection.execute(sql).values.flatten.join.to_i
  puts "#{table_name}: #{initial_count}"
  sql = "TRUNCATE #{table_name} CASCADE"
  connection.execute(sql)
  final_count = connection.execute(sql).values.flatten.join.to_i
  puts "#{table_name}: #{final_count}"
end

ActiveRecord::Base.connection.tables.each do |table_name|
  unless ["ar_internal_metadata", "schema_migrations"].include?(table_name)
    truncate_table(table_name, connection)
  end
end

puts "----------------END------------------"
