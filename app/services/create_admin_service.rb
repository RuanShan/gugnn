class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.nickname =  Rails.application.secrets.admin_name
        user.cellphone =  Rails.application.secrets.admin_cellphone
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.admin!
    end
  end
end
