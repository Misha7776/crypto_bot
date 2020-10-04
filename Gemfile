source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'api-pagination'
gem 'apitome'
gem 'blueprinter'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise-jwt'
gem 'httparty'
gem 'oj'
gem 'pagy'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 6.0.0'
gem 'rails_event_store'
gem 'r_creds'
gem 'redis'
gem 'redis-rails'
gem 'rspec_api_documentation'
gem 'sidekiq'
gem 'telegram-bot'
gem 'xlog'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv'
  gem 'pry'
end

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubycritic'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fakeredis'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'rspec-sidekiq'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
