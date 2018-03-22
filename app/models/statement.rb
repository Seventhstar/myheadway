class Statement < ActiveRecord::Base
  belongs_to :author
  belongs_to :user
  belongs_to :book

  has_many :statementstags
  has_many :tags, through: :statementstags

  attr_accessor :author_name
  attr_accessor :book_name
  
  attr_reader :tag_tokens
  
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  def tags_names
    self.tags.collect{ |t| t.name}.join(", ")
  end

  def author_name
    #author.name if !author.nil?
    author.try(:name)
  end

  def get_random()
    self.order("RANDOM()").first
  end
  
  def author_name=(name)
    self.author = Author.find_or_create_by(name: name) if name.present?
  end


   def book_name
    #author.name if !author.nil?
    book.try(:name)
  end

   def book_name=(name)
    self.book = Book.find_or_create_by(name: name) if name.present?
  end

  def ae_some_html
    # converting newlines 
    s = self.content
    s.gsub!(/\r\n?/, "\n") 
 
    # escaping HTML to entities 
    s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;') 
 
    # blockquote tag support 
    s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>") 
 
    # other tags: b, i, em, strong, u 
    %w(b i em strong u).each { |x|
         s.gsub!(Regexp.new('&lt;(' + x + ')&gt;(.+?)&lt;/('+x+')&gt;',
                 Regexp::MULTILINE|Regexp::IGNORECASE), 
                 "<\\1>\\2</\\1>") 
        } 
 
    # replacing newlines to <br> ans <p> tags 
    # wrapping text into paragraph 
    s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").
            gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>" 
 
    self.content =s      
    end 

    def self.search(search)
    if search
      search_str = search.upcase
      where('content LIKE ?', "%#{search_str}%")
    else
      all
    end
  end


end
