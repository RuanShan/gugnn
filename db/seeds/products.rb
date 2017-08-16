products = [
  { category: '电脑' }
]

users = 10.times.map{|i|
  FactoryGirl.create :user,cellphone: FFaker::PhoneNumberCH.mobile_phone_number, nickname: "test#{i}",realname: FFaker::NameCN.name, email: FFaker::Internet.email
}


products.each{|product_attrs|

  category = Category.find_by_title!( product_attrs[:category])
  category_options = category.category_options.includes(:option_values)
  1000.times{|i|
    product = Product.new
    product.owner = users.sample
    product.category =category
    product.title = FFaker::Product.product_name
    product.price = rand(1000)
    product.tenancy = [3600, 3600*24, 3600*24*30, 3600*24*365].sample
    product.deposit = rand(1000)
    product.desc = FFaker::LoremCN.paragraph
    #
    category_options.each{|co|
      product[co.filter_column_name] = co.option_values.sample.id
    }
    product.save!
  }
}
