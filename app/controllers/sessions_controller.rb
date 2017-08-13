class SessionsController < Devise::SessionsController
=begin
  def create
    self.resource = User.login(user_params)
    if self.resource
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      render :new
    end
  end
=end
  #def destroy
  #  logout
  #  flash[:notice] = "Successfully logged out."
  #  redirect_to site_path
  #end

private
  def user_params
    params.require(:user).permit(:cellphone, :password)
  end
end
