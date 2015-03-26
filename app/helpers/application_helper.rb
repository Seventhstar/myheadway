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

  def edit_delete(element, subcount = 0, invisible = false)

    hidden = invisible ? "hid": ""

    content_tag :div,{:class=>"edit_delete #{hidden}"} do
		ed = link_to image_tag('edit.png'), edit_polymorphic_path(element) 
 		
    

    subcount ||= 0
		if subcount>0 
  			de = image_tag('delete-disabled.png')
		else
  			de = link_to image_tag('delete.png'), element, method: :delete, data: { confirm: 'Действительно удалить?' }
		end 

		ed + de
	end
  end

end
