#!/bin/sh

function setup_db_and_create_user {
    echo "Running database setup"
    rake db:setup
    echo "running database seed"
    rake db:seed
}

# This is from https://stackoverflow.com/questions/17150064/how-to-check-if-the-database-exists-or-not-in-rails-before-doing-a-rake-dbsetup
echo "Attempting to migrate or setup database"
rake db:migrate 2>/dev/null || setup_db_and_create_user

echo "Database setup successful"
echo "Running '$@'"
exec "$@"
