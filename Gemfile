source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
#ruby '2.2.4'
if Gem.win_platform?
  #gem 'coffee-script-source', '1.8.0'
  gem 'wdm', '>= 0.1.0'
  gem 'bcrypt-ruby', '3.1.1.rc1', :require => 'bcrypt'
  gem 'rucaptcha', path: "../rucaptcha/rucaptcha-master"
else
  gem 'rucaptcha'
end

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

gem 'tinymce-rails'
gem 'tinymce-rails-langs'

gem 'acts_as_list'
gem 'awesome_nested_set'
gem "paperclip"
gem 'gmaps4rails'
gem 'geocodio'
gem 'ratyrate'
gem 'kaminari' #分页
gem 'ckeditor' #富文本编辑器


group :development do
  gem 'foreman'
  gem 'hub', :require=>nil
  gem 'rails_layout'
end
group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rubocop'
end
