# rename AverageCache AverageCach
# 修正使用 rails generate administrate:install 错误
# /home/david/.rvm/gems/ruby-2.2.4/gems/administrate-0.8.1/lib/generators/administrate/dashboard/dashboard_generator.rb:111:in `const_get': uninitialized constant AverageCach (NameError)

class AverageCach < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
end
