module ApplicationHelper
  def build_breadscrambs( category )
    #首页 > 大连市区办公设备租赁 > 大连市区打印机复印机租赁 > 京瓷 KM-5050 出租【租金400元】
    #
    lis = [ content_tag( 'li', link_to( '首页', root_path)) ]
    category.self_and_ancestors.each{|cate|
      lis << content_tag( 'li', link_to( cate.title, category_path(cate)))
    }
    lis.join

  end

  def category_breadscrambs(category)
    sb=[]
    category.self_and_ancestors.each{|cate|
      sb << link_to( cate.title, category_path(cate))
    }
    sb.join(" - ")
  end

  def display_price( product )
    unit = case product.tenancy
      when 1
        '小时'
      when 24
        '天'
      when 7*24
        '周'
      when 24*30
        '月'
      when 24*90
        '季度'
      when 24*365
        '年'
      end
    "<b>#{product.price}</b>元/#{ product.display_tenancy}"
  end


  def product_image( product )
    if product.master_image.present?
      image_tag(product.master_image.photo.url, size: "140x140", alt: product.title, class:"pimg")
    else
      image_tag("default.png", size: "140x140", alt: product.title, class:"product-default-image")
    end
  end

  def user_avatar( user )
    avatar = user.avatar || user.build_avatar
    tag :img, src: avatar.url, alt: "头像", class: 'jjrlogo'
  end

  #def selected_city
  #  session[:selected_city]
  #end

  def parse_path(path)
    path_hash = Rails.application.routes.recognize_path(path)
    return path_hash[:controller], path_hash[:action]
  end

end
