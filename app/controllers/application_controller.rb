class ApplicationController < ActionController::Base
  include CommonHelper
  protect_from_forgery with: :exception
end
