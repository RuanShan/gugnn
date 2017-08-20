class MapController < ApplicationController
  def get_map
    respond_to do |format|
      format.js { render :get_map }
    end
  end
end
