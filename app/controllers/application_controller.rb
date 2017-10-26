class ApplicationController < ActionController::Base
  include Pundit
  include Application::CommonHelper
  protect_from_forgery with: :exception
  before_action :handle_clickable

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  #如果 Params 包含 clickable_id, 统计页面中点击对象的 pv, 如：用户点击了某一个分类过滤属性

  def handle_clickable
    #创建 page_click JOB来处理,
    clickable_id = params[:clickable_id] # ex. option_value-11
    if clickable_id.present?
      PageClickStatJob.perform_later( clickable_id )
    end
  end

  def set_city
    if session[:city].blank?
      user = current_user
      #登陆用户
      if user
        session[:city] = user.city
      end
      #非登陆用户
      if session[:city].blank?
        #
        session[:city] = get_city_by_params || get_city_by_ip || t('defaults.city')
        if user
          user.update_attribute :city, session[:city]
        end
      end
    end
    session[:city]
  end

  # 这里取得的城市名是否和数据库中一致？
  def get_city_by_ip
    request.location.try(:city)
  end

  def get_city_by_params
    city = nil
    if params["city"].present? && HotCity.exists?( name:  params["city"])
      city = params["city"]
    end
    city
  end

end
