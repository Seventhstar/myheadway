module ApplicationHelper


	def getRandomStatement()
		@rand_statement = Statement.order("RANDOM()").first
	end

        def activeClassIfModel( model )
	     if model && model == self.controller_name.classify
	        "class=""active"""
	     else ""

	     end
	end

  def sortable_pil(column, title = nil)
    css_class = column == params[:tgroup_id] ? "active " : ""
    css_class.concat(" sort-pil")
    
    link_to title, "targets?tgroup_id="+column.to_s,{:class => css_class, :sort => column }

  end


end
