source 'https://rubygems.org'

ruby '2.3.4'

gem 'rails', '4.2.10'
gem 'stripe'
gem "pg", "~> 0.18"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem "autoprefixer-rails"

gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'bcrypt', '~> 3.1.7'

gem 'puma'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

gem 'paperclip', :git=> 'https://github.com/thoughtbot/paperclip', :ref => '523bd46c768226893f23889079a7aa9c73b57d68'
gem 'aws-sdk', '>= 2.0'

gem 'gibbon'

gem 'figaro'
gem 'roo', '~> 2.3'
gem 'stringex', '~> 2.6'

gem 'redcarpet'

group :development, :test do
  gem 'pry-rails'
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rubocop'
end

group :production, :staging do
  gem 'rails_12factor'
end
