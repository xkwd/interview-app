source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.3'
gem 'haml', '~> 5.0', '>= 5.0.4'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rspec', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
end

group :test do
  gem 'shoulda-matchers'
end

group :development do
  gem 'better_errors', '~> 2.4'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
