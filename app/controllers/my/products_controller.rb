module My
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy, :withdraw, :unwithdraw]

    # GET /products
    # GET /products.json
    def index
      @user = current_user
      #@products = current_user.products.page(params[:page])
      @authenticated_products = current_user.products.where(status: :authenticated).page(params[:page])
      @withdrawed_products = current_user.products.where(status: :withdrawed).page(params[:page])
      @pending_products = current_user.products.where(status: :authenticating).page(params[:page])
      session[:main_page]=false
    end

    # GET /products/1
    # GET /products/1.json
    def show
      @product.increment!(:visits) if @product.owner_id != current_user.id
    end

    # GET /products/new
    def new
      @user = current_user
      @product = Product.new(category_id: params[:category_id])
      #为什么要创建一个图片对象？
      #@product.images.build
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
          format.html { redirect_to my_products_path, notice: '信息创建成功' }
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
        if @product.update(edit_product_params)
          format.html { redirect_to my_products_path(@product), notice: '信息更新成功' }
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
      redirect_url = session[:main_page].present? ? my_account_index_path : my_products_path
      respond_to do |format|
        format.html { redirect_to  redirect_url, notice: '信息删除成功' }
        format.json { head :no_content }
      end
    end


    def withdraw
      @product.withdrawed!
      @product.touch(:withdraw_at)
      redirect_url = session[:main_page].present? ? my_account_index_path : my_products_path
      respond_to do |format|
        format.html { redirect_to  redirect_url, notice: '信息下架成功.' }
        format.json { head :no_content }
      end
    end

    def unwithdraw
      @product.authenticated!
      @product.touch(:withdraw_at)
      redirect_url = session[:main_page].present? ? my_account_index_path : my_products_path
      respond_to do |format|
        format.html { redirect_to  redirect_url, notice: '信息上架成功.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
        @category = @product.category
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def product_params
        params.require(:product).permit(:title, :desc, :lease_desc, :category_id, :address, :price, :lat, :lng, :latlng_address, :tenancy, :deposit,
        :filt0, :filt1, :filt2, :filt3, :filt4, :filt5, :filt6, :filt7, :filt8, :filt9, images_attributes: [:caption, :photo])
      end

      def edit_product_params
        params.require(:product).permit(:title, :desc, :lease_desc, :category_id, :address, :price, :lat, :lng, :latlng_address, :tenancy, :deposit,
        :filt0, :filt1, :filt2, :filt3, :filt4, :filt5, :filt6, :filt7, :filt8, :filt9, images_attributes: [:id, :_destroy, :caption, :photo])
      end
  end

end
