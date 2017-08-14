products = [
  { category: '电脑' }
]

products.each{|product_attrs|

  category = Category.find_by_title!( product_attrs[:category])
  category_options = category.category_options.includes(:option_values)
  1000.times{|i|
    product = Product.new
    product.category =category
    product.title = FFaker::Product.model
    category_options.each{|co|
      product[co.filter_column_name] = co.option_values.sample.id
    }
    product.save!
  }
}
