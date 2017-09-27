module My
  class AccountController < BaseController
    before_action :set_user, only: [:change_password, :change_profile, :authentication, :auth_idcard, :auth_licence]

    def index
      @user = current_user
      #@products = current_user.products.page(params[:page])
      @authenticated_products = current_user.products.where(status: :authenticated).page(params[:page])
      @withdrawed_products = current_user.products.where(status: :withdrawed).page(params[:page])
      session[:main_page]=true
    end

    def change_password
      if request.patch?
        @user.change_password(password_params)
        if @user.errors.empty?
          flash[:notice] = t(:password_changed)
          redirect_to action: :index
        end
      end
    end

    def change_profile
      if request.patch?
        if @user.cellphone != profile_params["cellphone"]
          verify_sms
          unless @sms.errors.empty?
            @sms.errors.each{|key, value|
              @user.errors.add(key, value)
            }
          end
        end
        @user.update_attributes(profile_params) if @user.errors.empty?
        if @user.errors.empty?
          flash[:notice] = t(:profile_updated)
          redirect_to action: :index
        end
      end
    end

    def authentication
    end

    def auth_idcard
      if request.patch?
        @user.update(authentication_params)
        @user.id_auth_status_ready!
        if @user.errors.empty?
          redirect_to action: :authentication
          return
        end
      end
    end

    def auth_licence
      @user.auth_type=1
      if request.patch?
        @user.update(authentication_params)
        if @user.errors.empty?
          redirect_to action: :authentication
          return
        end
      end
    end

    private

    def set_user
      @user = User.find_by_id(params[:id])
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end

    def profile_params
      if params["user"]["avatar_remote_url"].present?
        if params["user"]["avatar_remote_url"][0,4] != "http"
          image_parts = params["user"]["avatar_remote_url"].split("/")
          name,ext = image_parts.last.split(".")
          new_name = name.split("-").first+"."+ext
          image_parts[image_parts.length-1] = new_name
          iurl = request.protocol+request.host_with_port+image_parts.join("/")
          params["user"]["avatar_remote_url"] = iurl
        end
        params.require(:user).permit(:avatar, :avatar_remote_url, :nickname, :cellphone, :validate_code)
      else
        params.require(:user).permit(:avatar, :nickname, :cellphone, :validate_code)
      end
    end

    def authentication_params
      params.require(:user).permit(:auth_type, :shop_name, :category_id, :id_number, :id_photo, :licence_photo, :city, :shop_address, :lat, :lng, :contact_person, :contact_phone, :contact_other)
    end

    def verify_sms
      permitted_params = profile_params
      serialized_sms = session[:sms]||{}
      # sms serialized as json in session, it is string key hash here
      @sms = Sms.new( phone: serialized_sms['phone'], code: serialized_sms['code'], send_at: serialized_sms['send_at'])
      @sms.verify_sign_up_sms( permitted_params['cellphone'],permitted_params['validate_code'])
    end

  end
end
