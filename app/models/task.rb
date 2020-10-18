class Task < ActiveRecord::Base
  belongs_to :task_cat

  def task_cat_name
    self.task_cat&.name
  end

  def self.this_week
    Task.where('start_date between ? and ?', Date.today, Date.today + 7.days)
        .order(:start_date)
  end

  def task_cat_img_num
    # puts "self.task_cat #{self.task_cat&.to_json}"
    # wfew
    self.task_cat&.img_num
  end
end