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

end
