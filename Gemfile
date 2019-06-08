source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.2'

gem 'bootsnap', '~> 1.4', '>= 1.4.4'
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'coffee-rails', '~> 5.0'
gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'friendly_id', '~> 5.2', '>= 5.2.5'
gem 'haml-rails', '~> 2.0'
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'lightbox2-rails', '~> 2.8', '>= 2.8.2.1'
gem 'meta-tags', '~> 2.11', '>= 2.11.1'
gem 'mini_magick', '~> 4.9', '>= 4.9.3'
gem 'pg', '~> 1.1', '>= 1.1.4'
gem 'puma', '~> 3.12', '>= 3.12.1'
gem 'rails', '~> 5.2.3'
gem 'ransack', '~> 2.1', '>= 2.1.1'
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.1', '>= 4.1.20'

group :development, :test do
  gem 'binding_of_caller', '~> 0.8.0'
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  gem 'faker', '~> 1.9', '>= 1.9.3'
  gem 'pry-byebug', '~> 3.7'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
  gem 'rspec', '~> 3.8'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers', '~> 4.0', '>= 4.0.1'
end

group :development do
  gem 'better_errors', '~> 2.5', '>= 2.5.1'
  gem 'listen', '~> 3.1', '>= 3.1.5'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  gem 'web-console', '~> 3.7'
end
