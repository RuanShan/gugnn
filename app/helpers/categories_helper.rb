module CategoriesHelper
  # 基于当前过滤条件，和给定option_value, 构建新的过滤链接
  # 如： 条件是：苹果 128G 24寸，option_value 是64G，
  # 生成的链接是 苹果 64G 24寸
  def link_to_with_filters( option_value )
    category_option_values = @category_option_values.dup
    category_option_values[option_value.category_option.position-1] = option_value.id
    #  /categories/5?combofilters=-----3
    path = category_path( @category, combofilters: category_option_values.join('-'))

    link_to option_value.title, path
  end

  # 基于当前过滤条件，和给定option_value, 构建新的过滤链接
  # 如： 条件是：苹果 128G 24寸，option_value 是64G，
  # 生成的链接是 苹果 64G 24寸
  def build_path_without_filters( option_value )
    category_option_values = @category_option_values.dup
    category_option_values[option_value.category_option.position-1] = nil
    #  /categories/5?combofilters=-----3
    path = category_path( @category, combofilters: category_option_values.join('-'))
  end

  # instance params
  # @product_filters
  # @category
  def show_product_filters( )
    option_values = @category_options.map(&:option_values).flatten
    filters = []
    @product_filters.each{|key, val|
      if key=~/filt/ #分类过滤条件
        option_value = option_values.select{|ov| ov.id == val}.first
        if option_value
          filters << link_to(  content_tag( 'em', option_value.title ) +  content_tag( 'i', 'x' ),   build_path_without_filters(option_value))
        end
      end
    }
    filters.join
  end

end
