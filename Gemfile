source 'https://rubygems.org'

plugin 'bundler-inject'
require File.join(Bundler::Plugin.index.load_paths("bundler-inject")[0], "bundler-inject") rescue nil

gem 'rails', '~> 6.1.0', '>= 6.1.7.6'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.7'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'foreman'
gem 'puma'

gem 'config'
gem 'listen'

# Sidekiq specific gems
gem 'sidecloq'
gem 'sidekiq'

# Services gems
gem 'minigit', '~> 0.0.4'
gem 'net-ssh', '~> 7.2.0'

gem 'awesome_spawn',        '~> 1.6'
gem 'default_value_for',    '~> 3.4'
gem 'haml_lint',            '~> 0.51', :require => false
gem 'manageiq-style',       '>= 1.4',  :require => false
gem 'more_core_extensions', '~> 4.4',  :require => 'more_core_extensions/all'
gem 'rugged',                          :require => false

gem 'octokit', '~> 4.8.0', :require => false
gem 'faraday', '~> 0.9.2'
gem 'faraday-http-cache', '~> 2.0.0'

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'simplecov', '>= 0.21.2'
  gem 'timecop'
end

group :test do
  gem 'factory_bot_rails'
  gem 'webmock'
end
