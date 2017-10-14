class SessionsController < Devise::SessionsController
  layout 'passport'

  def new_renter
    #copy from Devise::SessionsController#new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
  end

  private
    def user_params
      params.require(:user).permit(:cellphone, :password)
    end
end
