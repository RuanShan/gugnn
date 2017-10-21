class PageClickStatJob < ApplicationJob
  queue_as :low_priority

  def perform(clickable_id)
    pageable_type, pageable_id, clickable_type, clickable_id = clickable_id.split('-')
    case pageable_type+'/'+clickable_type
    when 'category/option_value'
      category = Category.find_by_id pageable_id
      option_value = OptionValue.find_by_id clickable_id # clickable_id可能为 0，用户选择 ‘不限’
      if category && option_value
        page_click = PageClick.find_or_initialize_by( pageable:category, clickable:option_value )
        #便于很快找到这个分类的热门属性
        page_click.pv+=1
        page_click.save!
      end
    end
  end
end
