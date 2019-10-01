source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '5.2.3'

gem 'pg' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'sass-rails' # Use SCSS for stylesheets
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets
gem 'turbolinks' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'carrierwave', '~> 1' # 画像保存用
gem 'rmagick' # 画像編集
gem 'haml-rails'
gem 'simple_form'
gem 'jquery-rails'
gem 'bootstrap'
gem 'devise' # for user/admin
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'omniauth-google-oauth2'
gem 'enumerize'
gem 'business_time'
gem 'acts_as_list'
gem 'fog' # for aws
gem 'dotenv-rails'

gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console' # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen'
  gem 'letter_opener'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara' # for system test
  gem 'selenium-webdriver' # for use selenium driver
  gem 'webdrivers' # for selenium_chrome_headless
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
