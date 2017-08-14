module CategoriesHelper
  def link_to_with_filters( option_value )
    category_option_values = @category_option_values.dup
    category_option_values[option_value.category_option.position-1] = option_value.id
    #  /categories/5?combofilters=-----3
    path = category_path( @category, combofilters: category_option_values.join('-'))

    link_to option_value.title, path
  end
end
