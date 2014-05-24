class Statementstag < ActiveRecord::Base
  belongs_to :statement
  belongs_to :tag
end
