source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.2', '>= 6.0.2.2'

# This should after rails but before any gems that might require it
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'active_interaction'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'blueprinter'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'faker' # need this in prod for demo seeds to work
gem 'jbuilder', '~> 2.7'
gem 'mobility', '~> 0.8.9'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5.0'
gem 'rack-timeout'
gem 'reform-rails'
gem 'sendgrid-ruby'
gem 'simple_form'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'binding_of_caller'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  # an XML formatter is required for fancier CircleCI results
  gem 'rspec_junit_formatter'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rerun'
  gem 'spring'
  gem 'spring-commands-rspec', require: false
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end
