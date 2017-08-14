# 办公设备 打印机 复印机 净水机 投影仪 电脑其它

taxons = [
  {
    :name=>'office-equipments',
    :title => "办公设备",
  },
  {
    :name=>'printer',
    :title => "打印机/复印机",
    :parent => "办公设备",
  },
  {
    :name=>'water',
    :title => "净水机",
    :parent => "办公设备"
  },
  {
    :title => "投影仪",
    :name=>'project',
     :parent => "办公设备",

  },
  {
    :name=>'pc',
    :title => "电脑",
    :parent => "办公设备" ,

  },
  {
    #舞台周边 舞台设备 灯光音响 庆典用品 演出道具 服装 其他
    :title => "演出会展",
  },
  {
    :title => "舞台周边",
    :parent => "演出会展"
  },
  {
    :title => "舞台设备",
    :parent => "演出会展"
  },
  {
    :title => "灯光音响",
    :parent => "演出会展"
  },
  {
    :title => "庆典用品",
    :parent => "演出会展"
  },
  {
    :title => "演出道具",
    :parent => "演出会展"
  },
  {
    :title => "服装",
    :parent => "演出会展"
  },
  {
    :title => "其他",
    :parent => "演出会展"
  },
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Category.find_by_title!(taxon_attrs[:parent])
  end
  Category.create!(taxon_attrs)
end

#类别 ：全部办公设备办公耗材办公文仪办公家具公司转让其他办公用品
#价格 ：全部50元以下50-100元100-200元200-500元500-1500元2000-3000元3000元以上
#新旧 ：全部全新95成新9成新8成新7成新及以下
#区域 ：全大连西岗中山沙河口甘井子高新园旅顺金州开发区瓦房店普兰店庄河大连周边

category_options = Lease::ComboFilters::PC_FILTERS

category_options.each do |option_attrs|
  option_attrs[:category] = Category.find_by_title!( option_attrs[:category])
  option_attrs[:option_values] = option_attrs[:option_values].map do |combo_values|
    key, val, title,   = *combo_values #'any',0,'不限'
    if val > 0
      OptionValue.new(id: val, title: title, name: key)
    end
  end.compact
  CategoryOption.create!(option_attrs)
end
