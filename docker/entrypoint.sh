#!/bin/sh

# This is from https://stackoverflow.com/questions/17150064/how-to-check-if-the-database-exists-or-not-in-rails-before-doing-a-rake-dbsetup
echo "Attempting to migrate or setup database"
rake db:migrate 2>/dev/null || rake db:setup

echo "Database setup successful"
echo "Running '$@'"
exec "$@"
