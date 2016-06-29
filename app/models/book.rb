class Book < ActiveRecord::Base
  has_many :statements
  belongs_to :author

  attr_accessor :author_name
  
  def author_name
    #author.name if !author.nil?
    author.try(:name)
  end
  
  def author_name=(name)
    self.author = Author.find_or_create_by(name: name) if name.present?
  end

end
