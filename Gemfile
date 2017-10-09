source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
#ruby '2.2.4'
#gem 'coffee-script-source', '1.8.0'
#gem 'wdm', '>= 0.1.0', platforms: [:mingw, :mswin]
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
#fix bcrypt.rb:12:in `require': 126: 找不到指定的模块。
#https://github.com/codahale/bcrypt-ruby/issues/142
#gem 'bcrypt-ruby', :require => 'bcrypt'
#gem 'rucaptcha', path: "../rucaptcha/rucaptcha-master"

gem 'rails', '~> 5.0.3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'administrate'
gem 'administrate-field-paperclip'

gem "jquery-fileupload-rails"
gem 'bootstrap-sass'
gem 'bourbon'
gem 'devise'
#gem 'devise-i18n'
gem 'pg'
#gem 'pundit'
gem 'simple_form'
#cache store
gem 'redis-rails'
#ip to location and map
gem 'geocoder'

gem 'acts_as_list'
gem 'awesome_nested_set'
gem "paperclip"

gem 'kaminari' #分页
gem 'ckeditor' #富文本编辑器

gem 'aasm' # https://github.com/aasm/aasm State machines for Ruby classes


group :development do
  gem 'foreman'
  gem 'hub', :require=>nil
  gem 'rails_layout'
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rubocop'
end
# 服务器测试阶段使用
gem 'factory_girl_rails'
gem 'ffaker'
