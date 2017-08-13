module My
  class AccountController < BaseController

    def index
      @user = current_user
    end

    private

    def secure_params
      params.require(:user).permit(:role)
    end

  end
end
