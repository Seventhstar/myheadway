class Tag < ActiveRecord::Base
  has_many :statementstags
  has_many :statements, through: :statementstags

  def self.tokens(query)
    #authors = where("name like ?", "%#{query}%")
    cquery = query.mb_chars.capitalize 
     tags =  where("name like ? or name like ?","#{cquery}_%","#{cquery}_%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "Новая метка: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end


end
