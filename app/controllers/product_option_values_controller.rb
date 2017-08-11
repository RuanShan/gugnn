class ProductOptionValuesController < ApplicationController
  before_action :set_product_option_value, only: [:show, :edit, :update, :destroy]

  # GET /product_option_values
  # GET /product_option_values.json
  def index
    @product_option_values = ProductOptionValue.all
  end

  # GET /product_option_values/1
  # GET /product_option_values/1.json
  def show
  end

  # GET /product_option_values/new
  def new
    @product_option_value = ProductOptionValue.new
  end

  # GET /product_option_values/1/edit
  def edit
  end

  # POST /product_option_values
  # POST /product_option_values.json
  def create
    @product_option_value = ProductOptionValue.new(product_option_value_params)

    respond_to do |format|
      if @product_option_value.save
        format.html { redirect_to @product_option_value, notice: 'Product option value was successfully created.' }
        format.json { render :show, status: :created, location: @product_option_value }
      else
        format.html { render :new }
        format.json { render json: @product_option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_option_values/1
  # PATCH/PUT /product_option_values/1.json
  def update
    respond_to do |format|
      if @product_option_value.update(product_option_value_params)
        format.html { redirect_to @product_option_value, notice: 'Product option value was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_option_value }
      else
        format.html { render :edit }
        format.json { render json: @product_option_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_option_values/1
  # DELETE /product_option_values/1.json
  def destroy
    @product_option_value.destroy
    respond_to do |format|
      format.html { redirect_to product_option_values_url, notice: 'Product option value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_option_value
      @product_option_value = ProductOptionValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_option_value_params
      params.require(:product_option_value).permit(:category_id, :product_id, :category_option_id, :title)
    end
end
