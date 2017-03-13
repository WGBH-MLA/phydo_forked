source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Add ruby implementation of readline to the bundle. This is easier than
  # resolving the dependencies for various opertating systems.
  gem 'rb-readline'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webmock'
  gem 'coveralls', require: false
  gem 'rails-controller-testing'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rubocop', '~> 0.34.0', require: false
  gem 'rubocop-rspec', '~> 1.3.0', require: false
  gem 'simplecov', require: false
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-nav'
  gem "factory_girl_rails", "~> 4.0", require: false
  gem 'launchy'
  gem 'database_cleaner'
end

gem 'curation_concerns', '~> 1.6.3'
gem 'rsolr', '~> 1.0'
gem 'devise'
gem 'devise-guests', '~> 0.3'
gem 'omniauth-cas'
gem 'archive-tar-minitar', '~> 0.5.2'
gem 'blacklight_range_limit', github: 'projectblacklight/blacklight_range_limit', branch: 'master'
gem 'preservation', github: 'WGBH/hydradam-preservation', branch: 'master'

# TODO
# This is part of a back port of a patch introduced in curation_concerns ~>
# 1.7.x. This should not be required after upgrading to cuation_concerns ~>
# 1.7.x. See https://github.com/projecthydra/curation_concerns/pull/1061/files
gem 'active_fedora-noid', '~> 2.0.0-beta5'


# TODO
# These are added as a convenient way to get Solr and Fedora running on a demo.
# Do we want to run these in production, or have something more robust?
gem 'solr_wrapper'
gem 'fcrepo_wrapper'
