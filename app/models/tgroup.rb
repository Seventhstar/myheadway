class Tgroup < ActiveRecord::Base
  # has_many :target_groups
  # has_many :targets, through: :target_groups
  has_many :targets, foreign_key: :group_id
end
