class SiteController < ApplicationController
  before_action :get_current_user

  def index
    @categories = Category.roots.limit( 4 )
  end

  private

  def get_current_user
    current_user
  end
end
