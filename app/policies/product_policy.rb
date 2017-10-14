class ProductPolicy < ApplicationPolicy
  def create?
    user.try(:licence_auth_status_done?) || user.try(:id_auth_status_done?)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
