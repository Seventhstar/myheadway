class Target < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Target', :foreign_key => "parent_id"
  has_many :targets, :foreign_key => "parent_id"
  has_many :target_groups
  has_many :tgroups, through: :target_groups
  belongs_to :user
  after_save :check_group
  attr_accessor :parent_name

  def parent_name
      parent.name if parent_id?
  end

	def check_group
      if !parent_id.nil? 
        tgroups.clear
      end
   end

end
