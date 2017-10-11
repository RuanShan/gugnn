class HotCitiesController < ApplicationController
  before_action :set_hot_city, only: [:show, :edit, :update, :destroy]

  # GET /hot_cities
  # GET /hot_cities.json
  def index
    @hot_cities = HotCity.all
  end

  # GET /hot_cities/1
  # GET /hot_cities/1.json
  def show
  end

  # GET /hot_cities/new
  def new
    @hot_city = HotCity.new
  end

  # GET /hot_cities/1/edit
  def edit
  end

  # POST /hot_cities
  # POST /hot_cities.json
  def create
    @hot_city = HotCity.new(hot_city_params)

    respond_to do |format|
      if @hot_city.save
        format.html { redirect_to @hot_city, notice: 'Hot city was successfully created.' }
        format.json { render :show, status: :created, location: @hot_city }
      else
        format.html { render :new }
        format.json { render json: @hot_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hot_cities/1
  # PATCH/PUT /hot_cities/1.json
  def update
    respond_to do |format|
      if @hot_city.update(hot_city_params)
        format.html { redirect_to @hot_city, notice: 'Hot city was successfully updated.' }
        format.json { render :show, status: :ok, location: @hot_city }
      else
        format.html { render :edit }
        format.json { render json: @hot_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hot_cities/1
  # DELETE /hot_cities/1.json
  def destroy
    @hot_city.destroy
    respond_to do |format|
      format.html { redirect_to hot_cities_url, notice: 'Hot city was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hot_city
      @hot_city = HotCity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hot_city_params
      params.require(:hot_city).permit(:name, :pingyi, :acronyms, :province, :status, :integer)
    end
end
