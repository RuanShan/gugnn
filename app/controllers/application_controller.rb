class ApplicationController < ActionController::Base
  include Application::CommonHelper

  protect_from_forgery with: :exception
end
