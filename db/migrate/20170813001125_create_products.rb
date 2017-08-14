class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
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

      t.string :type
      t.string :title
      t.string :desc
      t.string :slugged
      t.belongs_to :owner, foreign_key: {to_table: :users}
      t.integer :price
      t.belongs_to :category
      #为了减少表及工作量，使用filters作为过滤字段集合,这个方案不可行，
      #1，用户选择不限时，某一个字节为任意是导致无法利用过滤
      #各个租赁对象使用不同的类表示
      t.string :combofilters, length:12, null: false, default: '00000000'
      t.integer :filt0, null:false, default: 0
      t.integer :filt1, null:false, default: 0
      t.integer :filt2, null:false, default: 0
      t.integer :filt3, null:false, default: 0
      t.integer :filt4, null:false, default: 0
      t.integer :filt5, null:false, default: 0
      t.integer :filt6, null:false, default: 0
      t.integer :filt7, null:false, default: 0
      t.integer :filt8, null:false, default: 0
      t.integer :filt9, null:false, default: 0

      t.datetime :published_at #展示排序顺序
      t.timestamps
    end
  end
end
