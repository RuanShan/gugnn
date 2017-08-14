module Lease::ComboFilters
    # 电脑 PC
    #t.integer :f_brand, default: 0  # 品牌
    #t.integer :f_memory, default: 0  # 内存
    #t.integer :f_hd, default: 0  # 硬盘
    #t.integer :f_cpu, default: 0  # 硬盘
    #t.integer :f_screen, default: 0  # 屏幕尺寸

    #联想  华硕  苹果  戴尔  惠普  ThinkPad  神舟  三星  宏碁  东芝  索尼  其他
    PC_BRAND = { category:'电脑', name: 'brand', title: '品牌', option_values: [['any',0,'不限'],
      ['lenovo',1,'联想'],['asus',2,'华硕'],['apple',3,'苹果'],['dell',4,'戴尔'],
      ['hp',5,'惠普'],['thinkpad',6,'ThinkPad'],['hasee',7,'神舟'],['sumsung',8,'三星']
      ] }
    #1G  2G  4G  6G  8G  12G及以上  512M  256M及以下  其他
    PC_MEMORY = { category:'电脑', name: 'memory', title: '内存', option_values: [['any',0,'不限'],
      ['g1',101,'1G'],['g2',102,'2G'],['g4',104,'4G'],['g6',106,'6G'],
      ['g8',108,'8G'],['g12',109,'12G及以上'],['m512',110,'512M'],['m256',111,'256M及以下']
        ] }
    # 60G  80G  120G  128G  250G  500G  512G  1T及以上  其他
    PC_HD = { category:'电脑', name: 'hd', title:'硬盘', option_values: [['any',0,'不限'],
      ['g60',201,'60G'],['g80',202,'80G'],
      ['g120',203,'120G'],['g128', 204,'128G'],['g250',205,'250G'],
      ['g500',206,'500G'],['t1',210,'1T及以上'],['other',299,'其他']
        ] }

    PC_FILTERS = [PC_BRAND,PC_MEMORY, PC_HD]
end
