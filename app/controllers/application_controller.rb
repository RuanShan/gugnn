class ApplicationController < ActionController::Base
  include CommonHelper
  #include Application::CommonHelper
  protect_from_forgery with: :exception
end
