class CategoryOptionsController < ApplicationController
  before_action :set_category_option, only: [:show, :edit, :update, :destroy]

  # GET /category_options
  # GET /category_options.json
  def index
    @category_options = CategoryOption.all
  end

  # GET /category_options/1
  # GET /category_options/1.json
  def show
  end

  # GET /category_options/new
  def new
    @category_option = CategoryOption.new
  end

  # GET /category_options/1/edit
  def edit
  end

  # POST /category_options
  # POST /category_options.json
  def create
    @category_option = CategoryOption.new(category_option_params)

    respond_to do |format|
      if @category_option.save
        format.html { redirect_to @category_option, notice: 'Category option was successfully created.' }
        format.json { render :show, status: :created, location: @category_option }
      else
        format.html { render :new }
        format.json { render json: @category_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_options/1
  # PATCH/PUT /category_options/1.json
  def update
    respond_to do |format|
      if @category_option.update(category_option_params)
        format.html { redirect_to @category_option, notice: 'Category option was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_option }
      else
        format.html { render :edit }
        format.json { render json: @category_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_options/1
  # DELETE /category_options/1.json
  def destroy
    @category_option.destroy
    respond_to do |format|
      format.html { redirect_to category_options_url, notice: 'Category option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_option
      @category_option = CategoryOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_option_params
      params.require(:category_option).permit(:title)
    end
end
