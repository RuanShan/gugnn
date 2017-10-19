# about 关于我们，我是租户，我是租赁商
# help 帮助
# news 资讯中心
# 公司动态 行业资讯 产品资讯 融资租赁 租赁案例
taxons = [

  { title: "关于我们", ctype: BlogCategory.ctypes['about'], permalink: 'about-us' },
  { title: "我是租户", ctype: BlogCategory.ctypes['about'], permalink: 'i-am-rentee' },
  { title: "我是租赁商", ctype: BlogCategory.ctypes['about'], permalink: 'i-am-renter'  },
  { title: "公司动态", ctype: BlogCategory.ctypes['news'], permalink: 'company-news'   },
  { title: "行业资讯", ctype: BlogCategory.ctypes['news'], permalink: 'field-news'   },
  { title: "产品资讯", ctype: BlogCategory.ctypes['news'], permalink: 'product-news'   },
  { title: "融资租赁", ctype: BlogCategory.ctypes['news'], permalink: 'fund-news'   },
  { title: "租赁案例", ctype: BlogCategory.ctypes['news'], permalink: 'lease-news'   },
]

taxons.each do |taxon_attrs|
  unless BlogCategory.exists? taxon_attrs
    BlogCategory.create!(taxon_attrs)
  end
end

#关于我们 平台介绍 加入我们 媒体报道 服务协议 免责声明 联系我们
#我是租户 租赁流程 租赁保障 押金支付/退还 租金支付 租赁券使用 发票开取 免押金额度
#我是租赁商 租赁商进驻 为什么进驻 进驻流程 进驻协议 租赁商评价体系 交易佣金 押金/租金提现
posts = [
  { title:'平台介绍', blog_category: 'about-us' },
  { title:'加入我们', blog_category: 'about-us' },
  { title:'媒体报道', blog_category: 'about-us' },
  { title:'服务协议', blog_category: 'about-us' },
  { title:'免责声明', blog_category: 'about-us' },
  { title:'联系我们', blog_category: 'about-us' },

  { title:'租赁流程', blog_category: 'i-am-rentee' },
  { title:'租赁保障', blog_category: 'i-am-rentee' },
  { title:'押金支付/退还', blog_category: 'i-am-rentee' },
  { title:'租金支付', blog_category: 'i-am-rentee' },
  { title:'租赁券使用', blog_category: 'i-am-rentee' },
  { title:'发票开取', blog_category: 'i-am-rentee' },
  { title:'免押金额度', blog_category: 'i-am-rentee' },

  { title:'租赁商进驻', blog_category: 'i-am-renter' },
  { title:'为什么进驻', blog_category: 'i-am-renter' },
  { title:'进驻流程', blog_category: 'i-am-renter' },
  { title:'进驻协议', blog_category: 'i-am-renter' },
  { title:'租赁商评价体系', blog_category: 'i-am-renter' },
  { title:'交易佣金', blog_category: 'i-am-renter' },
  { title:'押金/租金提现', blog_category: 'i-am-renter' },
]
posts.each do |post_attrs|
  category_permalink = post_attrs.delete :blog_category
  category = BlogCategory.find_by_permalink(category_permalink)
  post_attrs[:blog_category] = category
  post_attrs[:content] = '文章内容示例'
  BlogPost.create!(post_attrs)

end
