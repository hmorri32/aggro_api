source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg',    '~> 0.18'
gem 'puma',  '~> 3.7'
gem 'active_model_serializers', '~> 0.10.0'
gem 'figaro'
gem 'faraday'
gem 'faker'
gem 'database_cleaner'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
