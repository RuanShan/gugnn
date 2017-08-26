module My
  class AccountController < BaseController

    def index
      @user = current_user
      #@products = current_user.products.page(params[:page])
      @authenticated_products = current_user.products.where(status: :authenticated).page(params[:page])
      @withdrawed_products = current_user.products.where(status: :withdrawed).page(params[:page])
      session[:main_page]=true
    end

    def change_password
      @user = User.find_by_id(params[:id])
      if request.patch?
        @user.change_password(password_params)
        if @user.errors.empty?
          flash[:notice] = t(:password_changed)
          redirect_to action: :index
        end
      end
    end

    def change_profile
      @user = User.find_by_id(params[:id])
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
      @user = User.find_by_id(params[:id])
      if request.patch?
        @user.authenticating = true
        @user.update(authentication_params)
        if @user.errors.empty?
          redirect_to action: :index
        end
      end
    end

    private

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:nickname, :cellphone, :validate_code)
    end

    def authentication_params
      params.require(:user).permit(:auth_type, :shop_name, :category_id, :id_number, :id_photo, :shop_photo, :city, :shop_address, :lat, :lng, :contact_person, :contact_phone, :contact_other)
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
