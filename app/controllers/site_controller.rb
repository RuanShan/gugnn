class SiteController < ApplicationController
  def index
    @categories = Category.roots.limit( 4 )
  end
end
