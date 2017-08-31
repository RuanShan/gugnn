class SiteController < ApplicationController
  before_action :get_current_user, :set_city

  def index
    @categories = Category.roots.includes(:children).limit( 8 )
    @all_categories = Category.roots.includes(:children)

  end

  def select_city
    if request.patch?
      session[:selected_city] = params["city"]
      if current_user.present?
        current_user.update_attribute :city, session[:selected_city]
      end
      redirect_to "/"
    end
  end

  private

  def get_current_user
    current_user
  end

  def set_city
    if session[:selected_city].blank?
      user = get_current_user
      #登陆用户
      if user
        session[:selected_city] = user.city
      end
      #非登陆用户
      if session[:selected_city].blank?
        #
        session[:selected_city] = get_city_by_ip || t('defaults.city')
      end
    end
    session[:selected_city]
  end

  def get_city_by_ip
    request.location.try(:city)
  end
end
