module ApplicationHelper


	def getRandomStatement()
		@rand_statement = Statement.order("RANDOM()").first
	end

  def menu_li(title, link)
     css_li = current_page?(link) ? "active": ""
     content_tag :li,{:class => css_li} do
        link_to title, link
     end
  end

  def sortable_pil(column, title = nil)
    css_class = column == @gr_id ? "active " : ""
    
       link_to title, "targets?tgroup_id="+column.to_s,{:class => css_class, :sort => column }
    

  end


end
