class Author < ActiveRecord::Base
  has_many :statements
  has_many :attentions
end 
