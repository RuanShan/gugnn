class SiteController < ApplicationController
  before_action :get_current_user, :get_city

  def index
    @categories = Category.roots.includes(:children).limit( 8 )
    @all_categories = Category.roots.includes(:children)

  end

  def select_city
    if request.patch?
      session[:selected_city] = params["city"]
      redirect_to "/"
    end
  end

  private

  def get_current_user
    current_user
  end

  def get_city
    session[:selected_city] ||= request.location ? request.location.city : t(:unknown)
  end
end
