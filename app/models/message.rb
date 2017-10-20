#用户申请认证时，发送消息给信息审核员
class Message < ApplicationRecord
  
  enum status: { new: 0, read: 1 }, _prefix: true
  #  因为系统使用 administrate 作为管理端，由于 administrate 有 bug, 无法识别 sender的class_name是 user, 所以无法生成链接编辑sender
  #  http://www.rubydoc.info/gems/administrate/Administrate/Field/BelongsTo
  #  valid_action?(:show, field.attribute)
  belongs_to :user, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validates_presence_of :title, :user, :recipient
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
