class CreateOfficeEquipments < ActiveRecord::Migration[5.0]
  def change
    #租赁品类
    #1. 车 船 飞机
    #2. 人（他人时间）租女/男友  租家政（月嫂 钟点工）租各行人才………..
    #3. 服装        演出服装 舞蹈服 晚会服 会展服 民族服装及定制
    #4. 婚庆 摄影    婚庆公司 婚纱礼服 婚庆场地 彩妆造型 舞台灯具 司仪
    #5. 办公设备     电脑 手机通讯 相机 网络设备 复印机 打印机 传真机 投影机 显示器
    #6. 家具 租赁    办公桌椅  沙发  屏风 床/床铺
    #7. 户外装备     帐篷 遮阳伞 睡袋 渔具 烧烤用品 娱乐游戏装备
    #8. 婴童用品      玩具 童车 童床 摇篮
    #9. 租宠物

    create_table :office_equipments do |t|
      t.belongs_to :category

      t.string :title
      t.string :desc
      t.string :slugged
      t.integer :owner_id
      t.integer :price

      #无法建立所有过滤字段的索引，需要使用 category_options表。

      #通用
      t.integer :f_new, default: 0  # 成新
      # 电脑：笔记本  一体机  台式机  平板  组装机
      # 投影仪： 便携商务  教育会议  主流工程
      t.integer :f_type, default: 0  # 类型

      # 办公设备
      t.integer :f_type, default: 0  # 类型

      # 电脑
      t.integer :f_brand, default: 0  # 品牌
      t.integer :f_memory, default: 0  # 内存
      t.integer :f_hd, default: 0  # 硬盘
      t.integer :f_cpu, default: 0  # 硬盘
      t.integer :f_screen, default: 0  # 屏幕尺寸

      # 打印机
      t.integer :f_paper, default: 0  # 最大尺寸
      t.integer :f_color, default: 0  # 支持彩色
      t.integer :f_speed, default: 0  # 速度
      t.integer :f_sides, default: 0  # 双面打印

      #投影仪
      # 便携商务  教育会议  主流工程
      t.integer :f_resolution, default: 0  # 分辨率
      t.integer :f_luminance, default: 0  # 亮度
      t.integer :f_light, default: 0  # 光源

      t.timestamps
    end
  end
end
