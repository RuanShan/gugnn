module ApplicationHelper
  def build_breadscrambs
    #首页 > 大连市区办公设备租赁 > 大连市区打印机复印机租赁 > 京瓷 KM-5050 出租【租金400元】

  end


  def display_price( product )
    unit = case product.tenancy
      when 3600
        '小时'
      when 3600*24
        '天'
      when 3600*24*30
        '月'
      when 3600*24*90
        '季度'
      when 3600*24*365
        '年'
      end
    "#{product.price}元/#{unit}"
  end
end
