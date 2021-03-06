class Target < ActiveRecord::Base
  belongs_to :parent, class_name: 'Target', foreign_key: "parent_id", optional: true
  belongs_to :tgroup, class_name: 'Tgroup', foreign_key: "group_id", optional: true
  belongs_to :count_name, optional: true
  belongs_to :sets_name, optional: true
  belongs_to :user
  after_save :check_group
  attr_accessor :parent_name

  def parent_name
    parent.name if parent_id?
  end

  def check_group
    if !parent_id.nil? && !tgroup.nil?
      self.update_attribute(:tgroup, nil)
    end
  end
end
