module My
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET /products
    # GET /products.json
    def index
Rails.logger.debug "current_user =#{current_user}"
      @user = current_user
      @products = current_user.products.page(params[:page])
    end

    # GET /products/1
    # GET /products/1.json
    def show
    end

    # GET /products/new
    def new
      @product = Product.new(category_id: params[:category_id])
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    # POST /products.json
    def create
      @product = Product.new(product_params)
      @product.owner = current_user

      respond_to do |format|
        if @product.save
          format.html { redirect_to my_products_path, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /products/1
    # PATCH/PUT /products/1.json
    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def product_params
        params.require(:product).permit(:title, :desc, :category_id, :address, :price, :filt0, :filt1, :filt2, :filt3, :filt4, :filt5, :filt6, :filt7, :filt8, :filt9)
      end
  end

end
