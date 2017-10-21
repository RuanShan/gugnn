class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  # 显示分类及分类下的产品
  # params - combofilters
  def show
    @category_options = @category.category_options.includes(:option_values)

    @product_filters = parse_product_filters
    @category_option_values = []
    @category_options.each{|co|
        @category_option_values[co.position-1] = @product_filters[co.filter_column_name]
    }

    @products = @category.products.includes(:owner).where(@product_filters).order(published_at: :desc).page params[:page]

    #category has children
    unless @category.leaf?
      categories = @category.descendants
      @hot_page_clicks = PageClick.on_option_values.where( pageable: categories ).includes(:clickable).limit( 8 )
      #@hot_option_values = @hot_page_clicks.map(&:clickable)
      #@hot_option_values = OptionValue.group(:category_option_id, :id).limit( 8) if @hot_option_values.blank?
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :desc, :slugged)
    end

    # params[:combofilters]: - seperated option_value id
    def parse_product_filters
      product_filters = {}
      combofilters = params[:combofilters].to_s
      if combofilters.present?
        combofilters.split('-').each_with_index{|id, i|
          #选择任意是 id = 0
          if id.to_i > 0
            product_filters["filt#{i}"] = id.to_i
          end
        }
      end
      product_filters
    end
end
