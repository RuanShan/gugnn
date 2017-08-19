# 办公设备 打印机 复印机 净水机 投影仪 电脑其它

taxons = [

  {  #1. 车 船 飞机
    :title => "交通工具", name:'transportation', slogen: '车|船|飞机' },
  { :title => "私家车",   :parent => "交通工具"  },
  { :title => "汽艇",   :parent => "交通工具"  },
  { :title => "商务车",   :parent => "交通工具"  },
  { :title => "大巴",   :parent => "交通工具"  },
  { :title => "婚车",   :parent => "交通工具"  },
  { :title => "邮轮",  :parent => "交通工具" },
  { :title => "私人飞机",  :parent => "交通工具" },
  { #2. 人（他人时间）租女/男友  租家政（月嫂 钟点工）租各行人才………..
    :title => "时间租赁",  name:'time', slogen: '人才|他人时间'},
  { :title => "租男/女友",   :parent => "时间租赁"  },
  { :title => "家政服务",   :parent => "时间租赁"  },
  { :title => "各行人才",   :parent => "时间租赁"  },
  # 3. 服装租赁
  { :title => "服装租赁", name:'fasion',  slogen: '演出服|民族服饰'},
  { :title => "演出服装",   :parent => "服装租赁"  },
  { :title => "民族服装",   :parent => "服装租赁"  },
  { :title => "服饰定制",   :parent => "服装租赁"  },
  { :title => "舞蹈服",   :parent => "服装租赁"  },
  { :title => "晚礼服",   :parent => "服装租赁"  },

  # 4.  婚庆公司 婚纱礼服 婚庆场地 彩妆造型 舞台灯具 司仪
  { :title => "婚庆摄影", name:'marry', slogen: '婚礼相关全方位' },
  { :title => "婚庆公司",   :parent => "婚庆摄影"  },
  { :title => "婚纱礼服",   :parent => "婚庆摄影"  },
  { :title => "婚庆场地",   :parent => "婚庆摄影"  },
  { :title => "彩妆造型",   :parent => "婚庆摄影"  },
  { :title => "舞台灯具",   :parent => "婚庆摄影"  },
  { :title => "司仪",   :parent => "婚庆摄影"  },
  # 5.办公设备
  {  name: 'office-equipments',   title: "办公设备", slogen: '办公器材|电子产品' },
  {  :name=>'printer',    :title => "打印机/复印机",    :parent => "办公设备",  },
  {  :name=>'water',    :title => "净水机",    :parent => "办公设备"  },
  {  :name=>'project', :title => "投影仪",   :parent => "办公设备",  },
  {  :name=>'pc',  :title => "电脑",    :parent => "办公设备" ,  },

  # 6.舞台周边 舞台设备 灯光音响 庆典用品 演出道具 服装 其他
  { :title => "生活家居", name:'furniture', slogen: '生活家具出租' },
  { :title => "办公桌椅",   :parent => "生活家居"  },
  { :title => "沙发",   :parent => "生活家居"  },
  { :title => "屏风",   :parent => "生活家居"  },
  { :title => "床/床铺",   :parent => "生活家居"  },

  #7. 户外装备     帐篷 遮阳伞 睡袋 渔具 烧烤用品 娱乐游戏装备
  { :title => "户外装备", name:'outing', slogen: '野外烧烤|游戏娱乐' },
  { :title => "帐篷",   :parent => "户外装备"  },
  { :title => "遮阳伞",   :parent => "户外装备"  },
  { :title => "睡袋",   :parent => "户外装备"  },
  { :title => "渔具",   :parent => "户外装备"  },
  { :title => "烧烤用品",   :parent => "户外装备"  },
  { :title => "娱乐游戏装备",   :parent => "户外装备"  },
  #8. 婴童用品      玩具 童车 童床 摇篮
  { :title => "婴童用品", name:'baby', slogen: '婴儿用品|玩具' },
  { :title => "玩具",   :parent => "婴童用品"  },
  { :title => "童车",   :parent => "婴童用品"  },
  { :title => "童床",   :parent => "婴童用品"  },
  { :title => "摇篮",   :parent => "婴童用品"  },
  { :title => "其他",   :parent => "婴童用品"  },
  # 9.租宠物
  { :title => "宠物租赁", name:'pet', slogen: '婴儿用品|玩具' },
  { :title => "宠物猫/狗",   :parent => "宠物租赁"  },
  { :title => "水族宠物",   :parent => "宠物租赁"  },
  { :title => "展示宠物",   :parent => "宠物租赁"  },
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
      #https://stackoverflow.com/questions/28145100/rails-on-heroku-after-push-get-pguniqueviolation-error-duplicate-key-valu
      OptionValue.new( title: title, name: key)
    end
  end.compact
  CategoryOption.create!(option_attrs)
end
