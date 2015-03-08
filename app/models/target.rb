class Target < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Target', :foreign_key => "parent_id"
  has_many :targets, :foreign_key => "parent_id"
  belongs_to :user
  attr_accessor :parent_name

  def parent_name
      parent.name if parent_id?
  end

end
