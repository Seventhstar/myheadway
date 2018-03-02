class Task < ActiveRecord::Base
  belongs_to :task_cat

  def self.this_week
    Task.where('start_date between ? and ?', Date.today, Date.today + 7.days)
  end
end