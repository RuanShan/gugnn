class SiteController < ApplicationController
  before_action :get_current_user, :set_city

  def index
    @categories = Category.roots.includes(:children).limit( 8 )
    @all_categories = Category.roots.includes(:children)

  end

  def be_renter

    policy = Pundit.policy(current_user, Product.new)
    #用户是否有发布信息的？
    unless policy.create?

      if current_user
        #当前用户可能登录
        flash[:notice] = '请先申请个人或企业认证，通过后获得信息发布权限！'
        redirect_to authentication_my_account_path( current_user )
      else
        #也可能没有登录
        session[:apply_to_be_renter]
        redirect_to login_path
      end
    else
      flash[:notice] = '您已通过认证，可以发布租赁信息！'
      redirect_to new_my_product_path
    end

  end

  def select_city
    # 山西，陕西 拼音是一样的，这里需要添加汉字名称排序
    @cities = HotCity.order(:ppinyin,:province, :position).to_a
    # province_first_letter:[ provinces ]
    @popular_cities = []
    @grouped_provinces = {}
    @grouped_cities = {}
    last_city = nil
    @cities.each{|city|
      if @grouped_provinces.key? city.ppinyin.first
        if last_city.province != city.province
          @grouped_provinces[city.ppinyin.first] << city
        end
      else
        @grouped_provinces[city.ppinyin.first]= [city]
      end
      @grouped_cities[city.ppinyin] ||= []
      @grouped_cities[city.ppinyin] << city

      @popular_cities << city if city.popular?
      last_city = city
    }
    if request.patch?
      session[:selected_city] = params["city"]
      if current_user.present?
        current_user.update_attribute :city, session[:selected_city]
      end
      redirect_to root_path
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
